//
//  ResponseStore.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/5/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire

public protocol ResponseStore
{
    var error: Error? { get }
    func data(for: URLRequest) -> Data
    func data(for: URL, withParameters params: Parameters?) -> Data
}
