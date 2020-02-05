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

// In some respects looking to come up with some kind of
// context (NSManagedObjectContext like) data type that
// provides easy access for querying/adding/updating data
// by various views
open class ArrayDataContext<Item>: ObservableObject where Item : Hashable
{
    @Published public var contents: [Item] = []
    
    // maybe makes more sense to be a requestable type
    // thinking it'll be less likely to need subclassing to allow for
    // polymorphic results.
    func loadData(parameters: Dictionary<String, Any>? = nil)
    {
    }
    
    // not sure if it would be best to have separate methods
    // representing each HTTP verb.
    func save(with request: Requestable<Item>)
    {
        // construct URLRequest to send data back up.
        // generate body for request if needed
    }
    
    public func isDirty(other: Item) -> Bool
    {
        return false
    }
}

open class ObjectDataContext<Item>: ObservableObject where Item : Hashable
{
    @Published public var value: Item
    private let arrayContext: ArrayDataContext<Item>?
    
    init(value: Item, arrayContext: ArrayDataContext<Item>?)
    {
        self.value = value
        self.arrayContext = arrayContext
    }
    
    func save(with request: Requestable<Item>)
    {
        // determine if current object is dirty.
        // if dirty send data up to server
        // if not do nothing
        // add changed item to array context if save was successful
    }
}

public protocol RequestableProtocol
{
    associatedtype Item
    
    var token: String { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    
    init(token: String)
    
    // define how generic item's request should be made.
    func createURLRequest() -> URLRequest
    
    // define how generic item's body data should be constructed if any.
    // should be string, data or other type?
    func generateBody(item: Item)
}

// make subclassable to allow references to context objects to easily
// spin up a requestable object with needed specific parameters
// in an explicit fashion.
//
// example:
//  DepartmentRequest(token: "some token", type: "IT")
//  Employee(token: "some token", firstName: "John", lastName: "Roberts")
//  EmployeeHistory(token: "some token", startDate: Date())
//
//  let context: ObjectDataContext<Employee>(self.document, self.arrayContext)
//  ... later in code say button action in pushed detail view
//  context.save(with: EmployeeRequest(token: self.token))
//  self.popBack
//
//  Perhaps have detail take array context as dependency
//  add new item to that context, then call save which
//  would determine what items have changed or been added
//  and perform appropriate post/put operations to send data
//  back up. Plus once view is transitioned back to list, no
//  need to re-query for data as its been added into the published
//  contents.
//
open class Requestable<Item> : RequestableProtocol
{
    public typealias Item = Item
    
    public var token: String
    public var parameters: Parameters?
    public var headers: HTTPHeaders?
    
    // ?? define allowed verb as prop!
    
    required public init(token: String)
    {
        self.token = token
    }
    
    public func createURLRequest() -> URLRequest
    {
        return URLRequest(url: URL(string: "")!)
    }
    
    public func generateBody(item: Item)
    {
    }
}
