//
//  ClockRepositoryTest.swift
//  AlarmClockTests
//
//  Created by Linkon Sid on 28/1/23.
//

import XCTest
@testable import AlarmClock

class ClockRepositoryTest: XCTestCase {
    var sut:ClockRepository!
    override class func setUp() {
        DIContainer.shared.register(type: ClockDataSource.self, component: ClockLocalDataSource())
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
