//
//  DataProviderMock.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
@testable import AdventureWorks

class ArrayDataContextMock<Item>: ArrayDataContext<Item> where Item : Hashable
{
    init(items: [Item])
    {
        self.contents = items
    }
    
    override func loadData(parameters: Dictionary<String, Any>? = nil)
    {
    }
    
    override func addData(item: Item)
    {
    }
    
    override func updateData(item: Item)
    {
    }
    
    override func save()
    {
    }
}
