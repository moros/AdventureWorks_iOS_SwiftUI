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

class ArrayTaskMock<Resource, Item>: ArrayTask<Resource, Item> where Item : Hashable, Item : BaseMappable
{
    init(items: [Item])
    {
        super.init()
        self.contents = items
    }
}
