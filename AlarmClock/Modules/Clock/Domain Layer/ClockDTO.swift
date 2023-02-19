//
//  ClockData.swift
//  AlarmClock
//
//  Created by Linkon Sid on 27/1/23.
//

import Foundation

struct ClockDTO:Identifiable {
    var id:String
    var timezone:TimeZone
    var local:String
    var gmt:String
}
