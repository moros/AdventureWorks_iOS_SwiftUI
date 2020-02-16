//
//  URLProtocolMock.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/13/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation

public class URLProtocolMock: URLProtocol
{
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    
    override public class func canInit(with request: URLRequest) -> Bool
    {
        return true
    }
    
    override public class func canonicalRequest(for request: URLRequest) -> URLRequest
    {
        return request
    }
    
    override public func startLoading()
    {
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Handler is unavailable.")
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override public func stopLoading()
    {
        
    }
}
