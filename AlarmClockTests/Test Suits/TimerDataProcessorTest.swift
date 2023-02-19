//
//  TimerDataProcessorTest.swift
//  HugeClockTests
//
//  Created by Linkon Sid on 27/1/23.
//

import XCTest
@testable import HugeClock

class TimerDataProcessorTest: XCTestCase {
    var sut:TimerDataProcessor!
    
    override func setUp() {
        super.setUp()
        sut = TimerDataProcessor()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    func test_create_model(){
        let mockData = (10,12,30)
        sut.createModelData(from: mockData)
        XCTAssertNotNil(sut.getModelData(), "No model data processed for timer")
    }
    func test_update_model(){
        let actualMockData = (hour:10,minute:12,second:30)
        let updatedMockData = (hour:11,minute:11,second:11)
        sut.createModelData(from: actualMockData)
        XCTAssertNotNil(sut.getModelData(), "No model data processed for timer")
        sut.updateModelData(from: updatedMockData)
        do{
            let data = try XCTUnwrap(sut.getModelData(), "no model data found")
            XCTAssert(data.hour == updatedMockData.hour, "model hour data not updated")
            XCTAssert(data.minute == updatedMockData.minute, "model minute data not updated")
            XCTAssert(data.second == updatedMockData.second, "model second data not updated")
        }
        catch{
            XCTFail("Error unwraping model data")
        }
        
    }
}
