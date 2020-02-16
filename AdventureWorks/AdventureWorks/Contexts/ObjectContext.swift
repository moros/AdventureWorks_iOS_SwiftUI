//
//  ObjectContext.swift
//  AdventureWorks
//
//  Created by dmason on 2/8/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireExtended

public enum SaveState
{
    case nothing
    case successful
    case failed
}

class ObjectContext<Resource, Item> where Item : Equatable, Item : Copyable, Item : Trackable, Item : Restorable
{
    public var value: Item
    public var resource: ResourceConvertible<Item>!
    
    private var original: Item
    private let manager: SessionManagerProtocol
    
    init(manager: SessionManagerProtocol = SessionManager.default, value: Item)
    {
        self.manager = manager
        self.value = value
        self.original = value.copy() as! Item
        
        guard let klass = Resource.self as? ResourceConvertible<Item>.Type else {
            print("Error grabbing class type for Resource<Item>.")
            return
        }
        
        self.resource = klass.init()
    }
    
    /// Resets value back to its original without changing the reference.
    /// This will be important when a component or controller has a reference
    /// to the object.
    func cancel()
    {
        self.value.restore(self.original as! Item.Item)
    }
    
    func save(onCompletion: @escaping ((SaveState) -> Void))
    {
        let method = self.original.isNew ? HTTPMethod.post : HTTPMethod.put
        guard let url = self.resource.createURL(method: method) else {
            print("Unable to retrieve URL request for resource.")
            return
        }
        
        if !isDirty() {
            onCompletion(.nothing)
            return
        }
        
        self.manager.request(url, method: method, parameters: nil, encoding: JSONEncoding.default).response { data in
            let statusCode = data.response?.statusCode ?? 0
            onCompletion(statusCode == 200 ? SaveState.successful : SaveState.failed)
        }
    }
    
    func isDirty() -> Bool
    {
        return self.original != self.value
    }
}
