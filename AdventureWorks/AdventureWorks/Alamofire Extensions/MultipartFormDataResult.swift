//
//  MultipartFormDataResult.swift
//  AdventureWorks
//
//  Created by dmason on 2/10/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation

public enum MultipartFormDataResult {
    case success(request: UploadRequestProtocol, streamingFromDisk: Bool, streamFileURL: URL?)
    case failure(Error)
}
