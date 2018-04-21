//
//  FourSquare_AppTests.swift
//  FourSquare AppTests
//
//  Created by Olli Sirviö on 04/04/2018.
//  Copyright © 2018 Olli Sirviö. All rights reserved.
//

import XCTest
@testable import FourSquare_App

class FourSquare_AppTests: XCTestCase {
    

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testURLSession(){
        
        let appkey = AppKey()
        let lat = Double(60.1705171)
        let lng = Double(24.935404)
        let expectation = XCTestExpectation(description: "Download Foursquare API Json")
        let urlString = String(describing:"https://api.foursquare.com/v2/venues/search?v=20171411&ll=\(lat)%2C\(lng)&query=Helsinki&intent=checkin&radius=30000&client_id=\(appkey.clientID)&client_secret=\(appkey.clientSecret)")
        
        _ = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else { return }
        
        _ = URLSession.shared.dataTask(with: url) { (data,response,error)  in
            XCTAssertNotNil(data, "No Data downloaded")
            
            expectation.fulfill()
        }
    }
    
    func testJsonDecoder(){
           var foursquare : FourSquare!
        let expectation = XCTestExpectation(description: "JsonDEcoder creates object correctly")
        
        if let path = Bundle.main.path(forResource: "testJson", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                foursquare =  try JSONDecoder().decode(FourSquare.self, from: jsonData)
                
                XCTAssertNotNil(foursquare, "JsonDecoder did not decode correctly")
         
                expectation.fulfill()
            }
            catch {
            
            }
        }
        

        
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
