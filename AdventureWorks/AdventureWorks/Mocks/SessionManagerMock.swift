//
//  MockSessionManager.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/5/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireExtended

// Should be in tests target but being used for demo purposes so server responses can be mocked
// when demo app is run!
public class SessionManagerMock: SessionManagerProtocol
{
    let responseStore: ResponseStore
    let multipartFormDataMock: MultipartFormData?
    let multipartFormDataResultMock: MultipartFormDataResult?
    
    public init(responseStore: ResponseStore = DefaultResponseStore(), multipartFormDataMock: MultipartFormData? = nil, multipartFormDataResultMock: MultipartFormDataResult? = nil)
    {
        self.responseStore = responseStore
        self.multipartFormDataMock = multipartFormDataMock
        self.multipartFormDataResultMock = multipartFormDataResultMock
    }
    
    @discardableResult
    public func request(
        _ urlConvertable: URLConvertible,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders? = nil) -> DataRequestProtocol
    {
        let url = try! urlConvertable.asURL()
        let data = responseStore.data(for: url, withParameters: parameters)
        return DataRequestMock(
            data: data,
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    public func request(_ urlRequest: URLRequestConvertible) -> DataRequestProtocol
    {
        let request = try! urlRequest.asURLRequest()
        let data = responseStore.data(for: request)
        return DataRequestMock(
            data: data,
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    @discardableResult
    public func download(_ url: URLConvertible,
                  method: HTTPMethod = .get,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = URLEncoding.default,
                  headers: HTTPHeaders? = nil,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DownloadRequestProtocol
    {
        let url = try! url.asURL()
        let data = responseStore.data(for: url, withParameters: parameters)
        return DownloadRequestMock(
            data: data,
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    @discardableResult
    public func download(_ urlRequest: URLRequestConvertible,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DownloadRequestProtocol
    {
        let request = try! urlRequest.asURLRequest()
        let data = responseStore.data(for: request)
        return DownloadRequestMock(
            data: data,
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    @discardableResult
    public func download(resumingWith resumeData: Data,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DownloadRequestProtocol
    {
        return DownloadRequestMock(
            data: resumeData,
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    @discardableResult
    public func upload(_ fileURL: URL, to url: URLConvertible, method: HTTPMethod = .post, headers: HTTPHeaders? = nil) -> UploadRequestProtocol
    {
        let data = responseStore.data(for: fileURL)
        return UploadRequestMock(
            data: data,
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    @discardableResult
    public func upload(_ fileURL: URL, with urlRequest: URLRequestConvertible) -> UploadRequestProtocol
    {
        let request = try! urlRequest.asURLRequest()
        let data = responseStore.data(for: request)
        return UploadRequestMock(
            data: data,
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    @discardableResult
    public func upload(_ data: Data, to url: URLConvertible, method: HTTPMethod = .post, headers: HTTPHeaders? = nil) -> UploadRequestProtocol
    {
        let convertedURL = try! url.asURL()
        return UploadRequestMock(
            data: responseStore.data(for: convertedURL),
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    @discardableResult
    public func upload(_ data: Data, with urlRequest: URLRequestConvertible) -> UploadRequestProtocol
    {
        let request = try! urlRequest.asURLRequest()
        return UploadRequestMock(
            data: responseStore.data(for: request),
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    @discardableResult
    public func upload(_ stream: InputStream, to url: URLConvertible, method: HTTPMethod = .post, headers: HTTPHeaders? = nil) -> UploadRequestProtocol
    {
        let convertedURL = try! url.asURL()
        return UploadRequestMock(
            data: responseStore.data(for: convertedURL),
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    @discardableResult
    public func upload(_ stream: InputStream, with urlRequest: URLRequestConvertible) -> UploadRequestProtocol
    {
        let request = try! urlRequest.asURLRequest()
        return UploadRequestMock(
            data: responseStore.data(for: request),
            error: self.responseStore.error,
            request: self.responseStore.request,
            response: self.responseStore.response
        )
    }
    
    public func upload(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
        to url: URLConvertible,
        method: HTTPMethod = .post,
        headers: HTTPHeaders? = nil,
        queue: DispatchQueue? = nil,
        encodingCompletion: ((MultipartFormDataResult) -> Void)?)
    {
        // since the multipartFormData closure is required makes sense to error when
        // the SessionManagerMock instance wasn't provided form data to return.
        guard let formDataMock = self.multipartFormDataMock else {
            fatalError("MultipartFormData mock not provided.")
        }
        multipartFormData(formDataMock)
        
        // Since encodingCompletion closure is optional, no reason to error.
        guard let completion = encodingCompletion else {
            return
        }
        
        // If given a closure but no mock then probably makes sense to error.
        guard let result = self.multipartFormDataResultMock else {
            fatalError("MultipartFormDataResult mock not provided.")
        }
        
        completion(result)
    }
    
    public func upload(
        multipartFormData: @escaping (MultipartFormData) -> Void,
        usingThreshold encodingMemoryThreshold: UInt64 = SessionManager.multipartFormDataEncodingMemoryThreshold,
        with urlRequest: URLRequestConvertible,
        queue: DispatchQueue? = nil,
        encodingCompletion: ((MultipartFormDataResult) -> Void)?)
    {
        // since the multipartFormData closure is required makes sense to error when
        // the SessionManagerMock instance wasn't provided form data to return.
        guard let formDataMock = self.multipartFormDataMock else {
            fatalError("MultipartFormData mock not provided.")
        }
        multipartFormData(formDataMock)
        
        // Since encodingCompletion closure is optional, no reason to error.
        guard let completion = encodingCompletion else {
            return
        }
        
        // If given a closure but no mock then probably makes sense to error.
        guard let result = self.multipartFormDataResultMock else {
            fatalError("MultipartFormDataResult mock not provided.")
        }
        
        completion(result)
    }
}
