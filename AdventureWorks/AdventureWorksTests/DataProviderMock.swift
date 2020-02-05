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
        super.init()
        self.contents = items
    }
}
