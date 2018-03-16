//
//  EasyJSONTests.swift
//  EasyJSONTests
//
//  Created by Nicholas Mata on 6/26/17.
//  Copyright © 2017 MataDesigns. All rights reserved.
//

import XCTest
@testable import EasyJSON

class EasyJSONTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
/** Dictionary Tests **/
extension EasyJSONTests {
    func testDictToModelFull() {
        let jsonDict: [String : Any] = ["id" : 1, "firstName": "Nicholas", "lastName": "Mata"]
        let model = TestModel()
        measure {
            model.fill(withDict: jsonDict)
        }
        assert(model.id == jsonDict["id"] as! Int)
        assert(model.firstName == (jsonDict["firstName"] as! String))
        assert(model.lastName == (jsonDict["lastName"] as! String))
    }
    
    func testDictToModelPartial() {
        let jsonDict: [String : Any] = ["id" : 1, "firstName": "Nicholas"]
        let model = TestModel()
        measure {
            model.fill(withDict: jsonDict)
        }
        assert(model.id == jsonDict["id"] as! Int)
        assert(model.firstName == (jsonDict["firstName"] as! String))
        assert(model.lastName == nil)
    }
    
    func testDictToModelEmpty() {
        let jsonDict: [String: Any] = [:]
        let model = TestModel()
        measure {
            model.fill(withDict: jsonDict)
        }
        assert(model.id == -1)
        assert(model.firstName == nil)
        assert(model.lastName == nil)
    }
    
}

/** String Tests **/
extension EasyJSONTests {
    
    
    func testStringToModelFull() {
        let id = 1
        let firstName = "Nicholas"
        let lastName = "Mata"
        
        let json = "{ \"id\": \(id), \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\"}"
        let model = TestModel()
        measure {
            try? model.fill(withJson: json)
        }
        assert(model.id == id)
        assert(model.firstName == firstName)
        assert(model.lastName == lastName)
    }
    
    func testStringToModelPartial() {
        let id = 1
        let firstName = "Nicholas"
        
        let json = "{ \"id\": \(id), \"firstName\": \"\(firstName)\"}"
        let model = TestModel()
        measure {
            try? model.fill(withJson: json)
        }
        assert(model.id == id)
        assert(model.firstName == firstName)
        assert(model.lastName == nil)
    }
    
    func testStringToModelEmpty() {
        let json = ""
        let model = TestModel()
        measure {
            try? model.fill(withJson: json)
        }
        assert(model.id == -1)
        assert(model.firstName == nil)
        assert(model.lastName == nil)
    }
}

/** Subobjects Tests **/
extension EasyJSONTests {
    func testSubobjectArray() {
        let jsonDict: [String : Any] = ["id" : 1,
                                        "firstName": "Nicholas",
                                        "lastName": "Mata",
                                        "addresses": [
                                            ["id": 1, "street": "123 Melrose Drive", "city": "Vista", "State" : "CA"],
                                            ["id": 2, "street": "123 Western Drive", "city": "Santa Cruz", "State" : "CA"]
                                        ]
                                       ]
        let model = TestModelSubobject()
        measure {
            model.fill(withDict: jsonDict)
        }
        assert(model.id == jsonDict["id"] as! Int)
        assert(model.firstName == (jsonDict["firstName"] as! String))
        assert(model.lastName == (jsonDict["lastName"] as! String))
        assert(model.addresses.first?.id == ((jsonDict["addresses"] as! [[String: Any]])[0]["id"] as! Int), "Subobject Addresses was not filled.")
    }
}

/** SnakeCase Tests **/
extension EasyJSONTests {
    func testFromSnake() {
        let jsonDict: [String : Any] = ["id" : 1,
                                        "first_name": "Nicholas",
                                        "last_name": "Mata",
                                        "addresses": [
                                            ["id": 1, "street": "123 Melrose Drive", "city": "Vista", "state" : "CA"],
                                            ["id": 2, "street": "123 Western Drive", "city": "Santa Cruz", "state" : "CA"]
            ]
        ]
        let model = TestModelSnakeCase()
        measure {
            model.fill(withDict: jsonDict)
        }
        assert(model.id == jsonDict["id"] as! Int)
        assert(model.firstName == (jsonDict["first_name"] as! String))
        assert(model.lastName == (jsonDict["last_name"] as! String))
        assert(model.addresses.first?.id == ((jsonDict["addresses"] as! [[String: Any]])[0]["id"] as! Int), "Subobject Addresses was not filled.")
    }
    
    func testToSnake() {
        let jsonDict: [String : Any] = ["id" : 1,
                                        "first_name": "Nicholas",
                                        "last_name": "Mata",
                                        "addresses": [
                                            ["id": 1, "street": "123 Melrose Drive", "city": "Vista", "state" : "CA"],
                                            ["id": 2, "street": "123 Western Drive", "city": "Santa Cruz", "state" : "CA"]
            ]
        ]
        let model = TestModelSnakeCase()
        measure {
            model.fill(withDict: jsonDict)
        }
        let modelJson = model.toJson()
        assert(modelJson["id"] as! Int == jsonDict["id"] as! Int)
        assert(modelJson["first_name"] as! String == (jsonDict["first_name"] as! String))
        assert(modelJson["last_name"] as! String == (jsonDict["last_name"] as! String))
        assert(((modelJson["addresses"] as! [[String: Any]])[0]["id"] as! Int) == ((jsonDict["addresses"] as! [[String: Any]])[0]["id"] as! Int), "Subobject Addresses was not filled.")
    }
}
