//
//  ObjectContextTests.swift
//  AdventureWorks_StoryboardTests
//
//  Created by dmason on 2/8/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import XCTest
@testable import AdventureWorks

class ObjectContextTests: XCTestCase
{
    var department: Department!
    var resourceMock: DepartmentResourceMock!
    var storeMock: DefaultResponseStore!
    var managerMock: SessionManagerMock!
    
    override func setUp()
    {
        super.setUp()
        
        self.department = Department()
        self.resourceMock = DepartmentResourceMock()
        self.storeMock = DefaultResponseStore()
        self.managerMock = SessionManagerMock(responseStore: self.storeMock)
    }
    
    override func tearDown()
    {
        self.department = nil
        self.resourceMock = nil
        self.storeMock = nil
        self.managerMock = nil
    }
    
    func test_objectContext_isNewSetToTrue_whenObjectsIsNewSetToTrue()
    {
        let sut = ObjectContext<DepartmentResource, Department>(value: self.department)
        
        XCTAssertEqual(sut.value.isNew, true)
    }
    
    func test_objectContext_isNewSetToFalse_whenObjectsIsNewSetToFalse()
    {
        let sut = ObjectContext<DepartmentResource, Department>(value: Department(isNew: false))
        
        XCTAssertEqual(sut.value.isNew, false)
    }
    
    func test_objectContext_isDirtySetToTrue_whenChildPropertyChanged()
    {
        let sut = ObjectContext<DepartmentResource, Department>(value: self.department)
        self.department.name = "Engineering"
        
        XCTAssertTrue(sut.isDirty())
    }
    
    func test_resourceMock_createURLRequest_calledWithPost_whenObjectIsNew()
    {
        let sut = ObjectContext<DepartmentResource, Department>(value: self.department)
        sut.resource = self.resourceMock
        sut.save(onCompletion: {_ in })
        
        XCTAssertEqual(self.resourceMock.createURLRequestCountForPost, 1)
    }
    
    func test_resourceMock_createURLRequest_calledWithPut_whenObjectIsNotNew()
    {
        let sut = ObjectContext<DepartmentResource, Department>(value: Department(isNew: false))
        sut.resource = self.resourceMock
        sut.save(onCompletion: {_ in })
        
        XCTAssertEqual(self.resourceMock.createURLRequestCountForPut, 1)
    }
    
    func test_context_saveCallbackWithNothing_whenNoChangesHaveBeenMade()
    {
        self.storeMock.response = HTTPURLResponse(url: URL(fileURLWithPath: "url"), statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sut = ObjectContext<DepartmentResource, Department>(manager: self.managerMock, value: department)
        sut.resource = self.resourceMock
        
        let expectation = XCTestExpectation(description: "Save's func onCompletion closure called with nothing state returned.")
        sut.save { state in
            XCTAssertEqual(state, .nothing)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_context_saveCallbackWithSuccess_whenServerResponseIsSuccessful()
    {
        self.storeMock.response = HTTPURLResponse(url: URL(fileURLWithPath: "url"), statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sut = ObjectContext<DepartmentResource, Department>(manager: self.managerMock, value: department)
        sut.resource = self.resourceMock
        department.name = "Engineering"
        
        let expectation = XCTestExpectation(description: "Save's func onCompletion closure called with successful state returned.")
        sut.save { state in
            XCTAssertEqual(state, .successful)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_context_saveCallbackWithFailure_whenServerResponseIsNotSuccessful()
    {
        self.storeMock.response = HTTPURLResponse(url: URL(fileURLWithPath: "url"), statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let sut = ObjectContext<DepartmentResource, Department>(manager: self.managerMock, value: department)
        sut.resource = self.resourceMock
        department.name = "Engineering"
        
        let expectation = XCTestExpectation(description: "Save's func onCompletion closure called with failed state returned.")
        sut.save { state in
            XCTAssertEqual(state, .failed)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
