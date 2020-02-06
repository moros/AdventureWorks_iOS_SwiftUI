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
    
    public init(data: Data? = nil)
    {
        self.data = data ?? Data()
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
