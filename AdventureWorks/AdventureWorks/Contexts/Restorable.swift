//
//  Restorable.swift
//  AdventureWorks
//
//  Created by dmason on 2/9/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation

protocol Restorable
{
    associatedtype Item
    
    func restore(_ item: Item)
}
