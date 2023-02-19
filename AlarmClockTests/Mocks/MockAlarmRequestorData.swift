//
//  MockAlarmRequestorData.swift
//  AlarmClockTests
//
//  Created by Linkon Sid on 30/1/23.
//

import Foundation
@testable import AlarmClock

struct MockAlarmRequestorData{
    static func getMocks()->[CreateAlarmRequestor]{
        return [CreateAlarmRequestor(time: Date(), isEnabled: true),CreateAlarmRequestor(time: Date(), isEnabled: true)]
    }
}
