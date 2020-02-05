//
//  ISODateTransform.swift
//  AdventureWorks
//
//  Created by dmason on 2/5/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import ObjectMapper

open class ISODateTransform: TransformType
{
    public typealias Object = Date
    public typealias JSON = String
    
    public init()
    {
    }
    
    public func transformFromJSON(_ value: Any?) -> Date?
    {
        guard let datestring = value as? String else {
            return nil
        }
        
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: datestring)!
        
        return date
    }
    
    public func transformToJSON(_ value: Date?) -> String?
    {
        let isoFormatter = ISO8601DateFormatter()
        let string = isoFormatter.string(from: value!)
        
        return string
    }
}
