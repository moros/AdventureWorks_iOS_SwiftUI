//
//  Department.swift
//  AdventureWorks
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation

public struct Department : Hashable, Identifiable
{
    public let id: Int
    let name: String
    let groupName: String
    let modified: Date?
}
