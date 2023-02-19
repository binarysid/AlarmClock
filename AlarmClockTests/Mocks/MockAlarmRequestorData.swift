//
//  MockAlarmRequestorData.swift
//  HugeClockTests
//
//  Created by Linkon Sid on 30/1/23.
//

import Foundation
@testable import HugeClock

struct MockAlarmRequestorData{
    static func getMocks()->[CreateAlarmRequestor]{
        return [CreateAlarmRequestor(time: Date(), isEnabled: true),CreateAlarmRequestor(time: Date(), isEnabled: true)]
    }
}
