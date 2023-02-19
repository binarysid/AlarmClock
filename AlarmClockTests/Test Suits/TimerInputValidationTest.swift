//
//  TimerInputValidationTest.swift
//  HugeClockTests
//
//  Created by Linkon Sid on 28/1/23.
//

import XCTest
@testable import HugeClock

class TimerInputValidationTest: XCTestCase {
    var sut:TimerInputValidator!
    
    override func setUp() {
        super.setUp()
        sut = TimerInputValidator()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_with_valid_input_1(){
        let hour = "4"
        let minute = "0"
        let seconds = "0"
        let hourLimit = 4
        let data = sut.validate(hour: hour, minute: minute, second: seconds, upto: hourLimit)
        XCTAssertNotNil(data, "Invalid input data for timer set")
    }
    func test_with_valid_input_2(){
        let hour = "3"
        let minute = "59"
        let seconds = "59"
        let hourLimit = 4
        let data = sut.validate(hour: hour, minute: minute, second: seconds, upto: hourLimit)
        XCTAssertNotNil(data, "Invalid input data for timer set")
    }
    func test_with_valid_input_3(){
        let hour = "2"
        let minute = "50"
        let seconds = "59"
        let hourLimit = 4
        let data = sut.validate(hour: hour, minute: minute, second: seconds, upto: hourLimit)
        XCTAssertNotNil(data, "Invalid input data for timer set")
    }
    func test_with_invalid_input_1(){
        let hour = "30"
        let minute = "103"
        let seconds = "340"
        let hourLimit = 4
        let data = sut.validate(hour: hour, minute: minute, second: seconds, upto: hourLimit)
        XCTAssertNil(data, "Timer Input Validator inappropriate execution")
    }
    func test_with_invalid_input_2(){
        let hour = "4"
        let minute = "20"
        let seconds = "0"
        let hourLimit = 4
        let data = sut.validate(hour: hour, minute: minute, second: seconds, upto: hourLimit)
        XCTAssertNil(data, "Timer Input Validator inappropriate execution")
    }
    func test_with_invalid_input_3(){
        let hour = "4"
        let minute = "0"
        let seconds = "1"
        let hourLimit = 4
        let data = sut.validate(hour: hour, minute: minute, second: seconds, upto: hourLimit)
        XCTAssertNil(data, "Timer Input Validator inappropriate execution")
    }
    func test_with_invalid_input_4(){
        let hour = "4"
        let minute = "1"
        let seconds = "0"
        let hourLimit = 4
        let data = sut.validate(hour: hour, minute: minute, second: seconds, upto: hourLimit)
        XCTAssertNil(data, "Timer Input Validator inappropriate execution")
    }
}
