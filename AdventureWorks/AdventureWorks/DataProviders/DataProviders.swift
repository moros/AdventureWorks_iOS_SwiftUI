//
//  ListDataProvider.swift
//  AdventureWorks
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

// In some respects looking to come up with some kind of
// context (NSManagedObjectContext like) data type that
// provides easy access for querying/adding/updating data
// by various views
open class ArrayDataContext<Item>: ObservableObject where Item : Hashable
{
    @Published public var contents: [Item] = []
    
    func loadData(parameters: Dictionary<String, Any>? = nil)
    {
    }
    
    func addData(item: Item)
    {
    }
    
    func updateData(item: Item)
    {
    }
    
    func save()
    {
    }
}

open class ObjectDataContext<Item>: ObservableObject where Item : Hashable
{
    @Published public var value: Item
    
    init(value: Item)
    {
        self.value = value
    }
    
    func save()
    {
    }
}
