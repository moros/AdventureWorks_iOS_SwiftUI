//
//  ListDataProvider.swift
//  AdventureWorks
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireExtended
import Combine
import SwiftUI
import SwiftyJSON
import ObjectMapper

// In some respects looking to come up with some kind of
// context (NSManagedObjectContext like) data type that
// provides easy access for querying/adding/updating data
// by various views
class ArrayContext<Resource, Item>: ObservableObject where Item : Equatable, Item : Copyable, Item : Trackable, Item: BaseMappable
{
    @Published public var array: [Item] = []
    
    private let manager: SessionManagerProtocol
    
    public init(manager: SessionManagerProtocol = SessionManager.default)
    {
        self.manager = manager
    }
    
    // maybe makes more sense to be a requestable type
    // thinking it'll be less likely to need subclassing to allow for
    // polymorphic results.
    func loadData(withParameters parameters: Parameters?, onCompletion: @escaping (([Item]) -> Void))
    {
        guard let klass = Resource.self as? ResourceConvertible<Item>.Type else {
            print("Error grabbing class type for Requestable<Item>.")
            return
        }
        
        let resource = klass.init()
        
        guard let urlRequest = resource.createURLRequest(method: .get, withParameters: parameters) else {
            print("Unable to retrieve URL request for resource.")
            return
        }
        
        self.manager.request(urlRequest).responseJSON { response in
            switch (response.result) {
            case .success(let data):
                let json = JSON(data)
                guard let jsonString = json.rawString() else {
                    print("Error extracting raw JSON string.")
                    break
                }
                guard let items = Mapper<Item>().mapArray(JSONString: jsonString) else {
                    print("Error mapping array of \(Item.self)s.")
                    break
                }
                self.array = items
                onCompletion(items)
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    public func isDirty(other: Item) -> Bool
    {
        fatalError("isDirty(other:) not yet implemented")
    }
}
