//
//  ClockRepositoryTest.swift
//  HugeClockTests
//
//  Created by Linkon Sid on 28/1/23.
//

import XCTest
@testable import HugeClock

class ClockRepositoryTest: XCTestCase {
    var sut:ClockRepository!
    override class func setUp() {
        DIManager.shared.registerClockDataSource()
    }
    override func setUp() {
        super.setUp()
        sut = ClockRepository()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    func test_fetch_data_in_limit(){
        let limit = 5
        let data = sut.fetchData(limit: limit)
        XCTAssert(data.count>0, "Timezone list not found")
        XCTAssertTrue(data.count<=limit, "Timezone list size exceeds limit")
    }

}
