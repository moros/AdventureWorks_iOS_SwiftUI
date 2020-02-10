//
//  MockDataRequest.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/5/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire

// Should be in tests target but being used for demo purposes so server responses can be mocked
// when demo app is run!
public class DataRequestMock: DataRequestProtocol {
    
    let data: Data?
    let error: Error?
    
    let request: URLRequest?
    let response: HTTPURLResponse?
    let propertyListResponse: DataResponse<Any>?
    
    public init(data: Data? = nil, error: Error? = nil, request: URLRequest? = nil, response: HTTPURLResponse? = nil, propertyListResponse: DataResponse<Any>? = nil)
    {
        self.data = data
        self.error = error
        self.request = request
        self.response = response
        self.propertyListResponse = propertyListResponse
    }
    
    @discardableResult
    public func response(queue: DispatchQueue?,
                         completionHandler: @escaping (DefaultDataResponse) -> Void) -> Self
    {
        let response = DefaultDataResponse(request: self.request, response: self.response, data: self.data, error: self.error)
        completionHandler(response)
        return self
    }
    
    @discardableResult
    public func responseData(queue: DispatchQueue?,
                             completionHandler: @escaping (DataResponse<Data>) -> Void) -> Self
    {
        let result = self.error == nil ? Result.success(self.data!) : Result.failure(self.error!)
        let response = DataResponse<Data>(request: self.request, response: self.response, data: self.data, result: result)
        completionHandler(response)
        return self
    }
    
    @discardableResult
    public func responseString(queue: DispatchQueue?,
                               encoding: String.Encoding?,
                               completionHandler: @escaping (DataResponse<String>) -> Void) -> Self
    {
        let result = self.error == nil ? Result.success(String(decoding: self.data!, as: UTF8.self)) : Result.failure(self.error!)
        let response = DataResponse<String>(request: self.request, response: self.response, data: self.data, result: result)
        completionHandler(response)
        return self
    }
    
    @discardableResult
    public func responseJSON(queue: DispatchQueue?,
                      options: JSONSerialization.ReadingOptions,
                      completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self {
        
        let result = Result {
            return try convertToJsonObject(with: data!, options: options, error: error)
        }
        let dataResponse = DataResponse(request: self.request, response: self.response, data: data, result: result)
        completionHandler(dataResponse)
        return self
    }
    
    @discardableResult
    public func responsePropertyList(queue: DispatchQueue?,
                                     options: PropertyListSerialization.ReadOptions,
                                     completionHandler: @escaping (DataResponse<Any>) -> Void) -> Self
    {
        // Cheating a bit by having the mock take in a data response dependency!
        guard let propListResponse = propertyListResponse else {
            fatalError("responsePropertyList(queue:options:completionHandler:) failed; mocked response not passed in.")
        }
        
        completionHandler(propListResponse)
        return self
    }
    
    public func cancel()
    {
        fatalError("cancel() has not been implemented")
    }
    
    // TODO: May need to move this to a MockDownloadRequest class
    @discardableResult
    public func downloadProgress(queue: DispatchQueue, closure: @escaping Request.ProgressHandler) -> Self
    {
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

public class DownloadRequestMock: DataRequestMock, DownloadRequestProtocol
{
    @discardableResult
    public func response(queue: DispatchQueue? = nil, completionHandler: @escaping (DefaultDownloadResponse) -> Void) -> Self
    {
        fatalError("response(queue:completionHandler:) has not been implemented")
    }
    
    @discardableResult
    public func responseData(queue: DispatchQueue? = nil,
                      completionHandler: @escaping (DownloadResponse<Data>) -> Void) -> Self
    {
        fatalError("responseData(queue:completionHandler:) has not been implemented")
    }
    
    @discardableResult
    public func responseString(queue: DispatchQueue? = nil,
                        encoding: String.Encoding? = nil,
                        completionHandler: @escaping (DownloadResponse<String>) -> Void) -> Self
    {
        fatalError("responseString(queue:encoding:completionHandler:) has not been implemented")
    }
    
    @discardableResult
    public func responseJSON(queue: DispatchQueue? = nil,
                      options: JSONSerialization.ReadingOptions = .allowFragments,
                      completionHandler: @escaping (DownloadResponse<Any>) -> Void) -> Self
    {
        fatalError("responseJSON(queue:options:completionHandler:) has not been implemented")
    }
    
    @discardableResult
    public func responsePropertyList(queue: DispatchQueue? = nil,
                              options: PropertyListSerialization.ReadOptions = [],
                              completionHandler: @escaping (DownloadResponse<Any>) -> Void) -> Self
    {
        fatalError("responsePropertyList(queue:options:completionHandler:) has not been implemented")
    }
}

public class UploadRequestMock: DataRequestMock, UploadRequestProtocol
{
    @discardableResult
    public func uploadProgress(queue: DispatchQueue = DispatchQueue.main, closure: @escaping Request.ProgressHandler) -> Self
    {
        fatalError("uploadProgress(queue:closure:) has not been implemented")
    }
}
