//
//  DataProviderMock.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import ObjectMapper
@testable import AdventureWorks

class ArrayContextMock<Resource, Item>: ArrayContext<Resource, Item> where Item : Equatable, Item : Copyable, Item : Trackable, Item: BaseMappable
{
    init(items: [Item])
    {
        super.init()
        self.contents = items
    }
}
