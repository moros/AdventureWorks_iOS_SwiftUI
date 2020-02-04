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

open class ArrayDataProvider<Item>: ObservableObject where Item : Hashable
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
}

open class ObjectDataProvider<Item>: ObservableObject where Item : Hashable
{
    @Published public var fetchedData: Item?
    
    func loadData(parameters: Dictionary<String, Any>? = nil)
    {
    }
    
    func addData(data: Item)
    {
    }
    
    func updateData(data: Item)
    {
    }
}
