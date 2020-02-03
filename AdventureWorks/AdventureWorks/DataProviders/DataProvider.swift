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

open class DataProvider<Item>: ObservableObject where Item : Hashable
{
    @Published public var fetchedData: [Item] = []
    
    func updateFetchedData(items: [Item])
    {
        self.fetchedData = items
    }
    
    func loadData(parameters: Dictionary<String, Any>? = nil)
    {
    }
}
