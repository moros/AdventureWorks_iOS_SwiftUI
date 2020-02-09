//
//  Copyable.swift
//  AdventureWorks
//
//  Created by dmason on 2/8/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation

protocol Copyable
{
    associatedtype Item
    
    func copy() -> Item
}
