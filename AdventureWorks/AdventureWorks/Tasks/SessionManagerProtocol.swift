//
//  SessionManagerProtocol.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/5/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire

public protocol SessionManagerProtocol
{
    @discardableResult
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?,
                 encoding: ParameterEncoding, headers: HTTPHeaders?)  -> DataRequestProtocol
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequestProtocol
    
    @discardableResult
    func download(_ url: URLConvertible,
                    method: HTTPMethod,
                    parameters: Parameters?,
                    encoding: ParameterEncoding,
                    headers: HTTPHeaders?,
                    to destination: DownloadRequest.DownloadFileDestination?) -> DataRequestProtocol
    
    @discardableResult
    func download(_ urlRequest: URLRequestConvertible,
                    to destination: DownloadRequest.DownloadFileDestination?) -> DataRequestProtocol
    
    @discardableResult
    func download(resumingWith resumeData: Data,
                    to destination: DownloadRequest.DownloadFileDestination?) -> DataRequestProtocol
    
}

public extension SessionManagerProtocol
{
    @discardableResult
    func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) -> DataRequestProtocol
    {
        return request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    @discardableResult
    func download(_ url: URLConvertible,
                  method: HTTPMethod = .get,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = URLEncoding.default,
                  headers: HTTPHeaders? = nil,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DataRequestProtocol
    {
        return download(url, method: method, parameters: parameters, encoding: encoding, headers: headers, to: destination)
    }
    
    @discardableResult
    func download(_ urlRequest: URLRequestConvertible,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DataRequestProtocol
    {
        return download(urlRequest, to: destination)
    }
    
    @discardableResult
    func download(resumingWith resumeData: Data,
                  to destination: DownloadRequest.DownloadFileDestination? = nil) -> DataRequestProtocol
    {
        return download(resumingWith: resumeData, to: destination)
    }
}

extension SessionManager: SessionManagerProtocol
{
    @discardableResult
    public func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?,
                 encoding: ParameterEncoding, headers: HTTPHeaders?)  -> DataRequestProtocol
    {
        let dataRequest: DataRequest = request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
        return dataRequest as DataRequestProtocol
    }
    
    public func request(_ urlRequest: URLRequestConvertible) -> DataRequestProtocol
    {
        let dataRequest: DataRequest = request(urlRequest)
        return dataRequest as DataRequestProtocol
    }
}
