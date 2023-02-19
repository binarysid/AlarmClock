//
//  ClockDataSourceTest.swift
//  HugeClockTests
//
//  Created by Linkon Sid on 28ß/1/23.
//

import XCTest
@testable import HugeClock

class ClockDataSourceTest: XCTestCase {
    var sut: ClockLocalDataSource!
    
    override func setUp() {
        super.setUp()
        sut = ClockLocalDataSource()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_fetch_data(){
        let data = sut.getData()
        XCTAssert(data.count>0, "No data found in Clock datasource")
        do{
            let firstData = try XCTUnwrap(data.first)
            XCTAssert(firstData == TimeZone.current.identifier, "First data in the list does not represent system timezone")
        }
        catch{
            XCTFail("Clock model data unwrapping error")
        }
    }
}
