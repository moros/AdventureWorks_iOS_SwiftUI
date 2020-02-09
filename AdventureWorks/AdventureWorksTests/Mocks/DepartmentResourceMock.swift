//
//  DepartmentResourceMock.swift
//  AdventureWorks_StoryboardTests
//
//  Created by dmason on 2/8/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire
@testable import AdventureWorks

class DepartmentResourceMock: ResourceConvertible<Department>
{
    var createURLRequestCountForPost = 0
    var createURLRequestCountForPut = 0
    
    required public init()
    {
    }
    
    override public func createURL(method: HTTPMethod, withParameters parameters: Parameters? = nil) -> String?
    {
        switch method {
        case .post:
            createURLRequestCountForPost += 1
        case .put:
            createURLRequestCountForPut += 1
        default:
            break
        }
        
        return "https://localhost"
    }
    
    override public func createURLRequest(method: HTTPMethod, withParameters parameters: Parameters? = nil) -> URLRequest?
    {
        switch method {
        case .post:
            createURLRequestCountForPost += 1
        case .put:
            createURLRequestCountForPut += 1
        default:
            break
        }
        
        return URLRequest(url: URL(string: "https://localhost")!)
    }
}
