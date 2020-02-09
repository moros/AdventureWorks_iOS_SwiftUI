//
//  ArrayContextTests.swift
//  AdventureWorksTests
//
//  Created by dmason on 2/5/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import XCTest
import Alamofire
@testable import AdventureWorks

class ArrayContextTests: XCTestCase
{
    func testArrayContextParsesResponseToExpectedModel()
    {
        let rawJson = "[\n  {\n    \"group_name\" : \"Research and Development\",\n    \"modified_date\" : \"2008-04-30T00:00:00Z\",\n    \"name\" : \"Engineering\",\n    \"department_id\" : 1\n  }\n]".data(using: .utf8)
        
        let manager = SessionManagerMock(responseStore: DefaultResponseStore(data: rawJson))
        let sut = ArrayContext<DepartmentResource, Department>(manager: manager)
        
        sut.loadData()
        
        XCTAssertEqual(sut.array.count, 1)
        XCTAssertEqual(sut.array[0].id, 1)
        XCTAssertEqual(sut.array[0].name, "Engineering")
        XCTAssertEqual(sut.array[0].groupName, "Research and Development")
        
        let transform = ISODateTransform()
        XCTAssertEqual(transform.transformToJSON(sut.array[0].modified), "2008-04-30T00:00:00Z")
    }
    
    func testArrayContextNoDataLoadedForError()
    {
        let manager = SessionManagerMock(responseStore: DefaultResponseStore(error: FakeError.unknown))
        let sut = ArrayContext<DepartmentResource, Department>(manager: manager)
        
        sut.loadData()
        
        XCTAssertEqual(sut.array.count, 0)
    }
}
