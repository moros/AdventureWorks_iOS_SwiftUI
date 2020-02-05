//
//  Department.swift
//  AdventureWorks
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public struct Department : Hashable, Identifiable, ImmutableMappable
{
    public let id: Int
    let name: String!
    let groupName: String!
    let modified: Date!
    
    public init(map: Map) throws
    {
        id = try map.value("department_id")
        name = try map.value("name")
        groupName = try map.value("group_name")
        modified = try map.value("modified_date", using: ISODateTransform())
    }
}

public class DepartmentResource: APIResource<Department>
{
    required public init()
    {
        super.init()
    }
    
    override public func createURLRequest(withParameters parameters: Parameters? = nil) -> URLRequest?
    {
        guard let url = URL(string: "https://localhost:5002/api/departments/index") else {
            return nil
        }
        return URLRequest(url: url)
    }
}
