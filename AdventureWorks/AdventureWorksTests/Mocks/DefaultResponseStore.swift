//
//  DefaultResponseStore.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/5/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire

public class DefaultResponseStore: ResponseStore
{
    private var data: Data
    public var error: Error?
    
    public init(data: Data? = nil, error: Error? = nil)
    {
        self.data = data ?? Data()
        self.error = error
    }
    
    public func error(for: URLRequest) -> Error?
    {
        return self.error
    }
    
    public func data(for request: URLRequest) -> Data
    {
        return self.data
    }
    
    public func data(for url: URL, withParameters params: Parameters?) -> Data
    {
        return self.data
    }
}
