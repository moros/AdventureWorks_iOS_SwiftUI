//
//  ListDataProvider.swift
//  AdventureWorks
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire
import Combine
import SwiftUI
import SwiftyJSON
import ObjectMapper

// In some respects looking to come up with some kind of
// context (NSManagedObjectContext like) data type that
// provides easy access for querying/adding/updating data
// by various views
open class ArrayContext<Resource, Item>: ObservableObject where Item : Hashable, Item: BaseMappable
{
    @Published public var contents: [Item] = []
    
    // maybe makes more sense to be a requestable type
    // thinking it'll be less likely to need subclassing to allow for
    // polymorphic results.
    func loadData(withParameters parameters: Parameters? = nil)
    {
        guard let klass = Resource.self as? APIResource<Item>.Type else {
            print("Error grabbing class type for Requestable<Item>.")
            return
        }
        
        let resource = klass.init()
        
        guard let urlRequest = resource.createURLRequest(withParameters: parameters) else {
            print("Unable to retrieve URL request for resource.")
            return
        }
        
        Alamofire.request(urlRequest).responseJSON { response in
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
                DispatchQueue.main.async {
                    self.contents = items
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    // not sure if it would be best to have separate methods
    // representing each HTTP verb.
    func save(using request: APIResource<Item>)
    {
        // construct URLRequest to send data back up.
        // generate body for request if needed
    }
    
    public func isDirty(other: Item) -> Bool
    {
        return false
    }
}

open class ObjectContext<Item>: ObservableObject where Item : Hashable
{
    @Published public var value: Item
    //private let arrayContext: ArrayDataContext<Item>?
    
//    init(value: Item, arrayContext: ArrayDataContext<Item>?)
    init(value: Item)
    {
        self.value = value
        //self.arrayContext = arrayContext
    }
    
    func save(using request: APIResource<Item>)
    {
        // determine if current object is dirty.
        // if dirty send data up to server
        // if not do nothing
        // add changed item to array context if save was successful
    }
}

/// Defines a reusable class for making API requests; sub-classed for each resource.
///
open class APIResource<Item> where Item : Hashable
{
    public typealias Item = Item
    
    public var token: String?
    public var parameters: Parameters?
    public var headers: HTTPHeaders?
    
    // ?? define allowed verb as prop!
    required public init()
    {
    }
        
    public func createURLRequest(withParameters parameters: Parameters? = nil) -> URLRequest?
    {
        return nil
    }
    
    public func generateBody(item: Item)
    {
    }
}
