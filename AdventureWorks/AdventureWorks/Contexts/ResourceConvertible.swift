//
//  ResourceConvertible.swift
//  AdventureWorks
//
//  Created by dmason on 2/8/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire

open class ResourceConvertible<Item>
{
    public var token: String?
    public var parameters: Parameters?
    public var headers: HTTPHeaders?
    
    required public init()
    {
    }
    
    public func createURL(method: HTTPMethod, withParameters parameters: Parameters? = nil) -> String?
    {
        return nil
    }
    
    public func createURLRequest(method: HTTPMethod, withParameters parameters: Parameters? = nil) -> URLRequest?
    {
        return nil
    }
}
