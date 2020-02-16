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

struct Department: Trackable, Equatable, Identifiable, ImmutableMappable
{
    typealias Item = Department
    
    public let id: Int
    let isNew: Bool
    var name: String?
    var groupName: String?
    var modified: Date?
    
    public init()
    {
        self.isNew = true
        self.id = 0
    }
    
    public init(isNew: Bool, name: String? = nil)
    {
        self.isNew = isNew
        self.name = name
        self.id = 0
    }
    
    public init(map: Map) throws
    {
        isNew = false
        id = try map.value("department_id")
        name = try map.value("name")
        groupName = try map.value("group_name")
        modified = try map.value("modified_date", using: ISODateTransform())
    }
    
    static func == (lhs: Department, rhs: Department) -> Bool
    {
        return lhs.isNew == rhs.isNew && lhs.name == rhs.name
    }
    
    static func != (lhs: Department, rhs: Department) -> Bool
    {
        return !(lhs == rhs)
    }
}

class DepartmentResource: ResourceConvertible<Department>
{
    required public init()
    {
        super.init()
    }
    
    override public func createURL(method: HTTPMethod, withParameters parameters: Parameters? = nil) -> String?
    {
        return "https://localhost:5002/api/departments/index"
    }
    
    override public func createURLRequest(method: HTTPMethod, withParameters parameters: Parameters? = nil) -> URLRequest?
    {
        guard let urlString = createURL(method: method, withParameters: parameters) else {
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        return URLRequest(url: url)
    }
}
