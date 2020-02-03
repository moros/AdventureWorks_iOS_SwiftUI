//
//  DataProviderMock.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
@testable import AdventureWorks

class DataProviderMock<Item>: DataProvider<Item> where Item : Hashable
{
    init(items: [Item])
    {
        self.fetchedData = items
    }
    
    override func loadData(parameters: Dictionary<String, Any>? = nil)
    {
    }
}
