//
//  MockDataRequest.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/5/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire
@testable import AdventureWorks

public class DataRequestMock: DataRequestProtocol {
    
    let data: Data
    let error: Error?
    
    public init(data: Data, error: Error? = nil) {
        self.data = data
        self.error = error
    }
    
    @discardableResult
    public func response(queue: DispatchQueue?,
                         completionHandler: @escaping (DefaultDataResponse) -> Void) -> Self {
        
        // TODO: ...
        fatalError("response(queue:completionHandler:) has not been implemented")
    }
    
    @discardableResult
    public func responseData(queue: DispatchQueue?,
                             completionHandler: @escaping (DataResponse<Data>) -> Void) -> Self {
        // TODO: ...
        fatalError("responseData(queue:completionHandler:) has not been implemented")
    }
    
    @discardableResult
    public func responseString(queue: DispatchQueue?,
                               encoding: String.Encoding?,
                               completionHandler: @escaping (DataResponse<String>) -> Void) -> Self {
        // TODO: ...
        fatalError("responseString(queue:encoding:completionHandler:) has not been implemented")
    }
    
    
    
    @discardableResult
    public func responseJSON(queue: DispatchQueue?,
                      options: JSONSerialization.ReadingOptions,
                      completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        
        let result = Result {
            return try convertToJsonObject(with: data, options: options, error: error)
        }
        let dataResponse = DataResponse(request: nil, response: nil, data: data, result: result)
        completionHandler(dataResponse)
        return self
    }
    
    @discardableResult
    public func responsePropertyList(queue: DispatchQueue?,
                                     options: PropertyListSerialization.ReadOptions,
                                     completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        // TODO: ...
        fatalError("responsePropertyList(queue:options:completionHandler:) has not been implemented")
    }
    
    public func cancel() {
        fatalError("cancel() has not been implemented")
    }
    
    // TODO: May need to move this to a MockDownloadRequest class
    @discardableResult
    public func downloadProgress(queue: DispatchQueue, closure: @escaping Request.ProgressHandler) -> Self {
        fatalError("downloadProgress(queue: queue, closure: closure) has not been implemented")
    }
    
    private func convertToJsonObject(with data: Data, options opt: JSONSerialization.ReadingOptions = [], error: Error?) throws -> Any
    {
        // If no error, else block will execute.
        guard let error = error else {
            return try JSONSerialization.jsonObject(with: data, options: opt)
        }
        
        // If we are given error, throw it so that Result<Value> will be .failure instead of .success
        throw error
    }
}
