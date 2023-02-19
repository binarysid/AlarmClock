//
//  CreateAlarmRequest.swift
//  HugeClock
//
//  Created by Linkon Sid on 28/1/23.
//
import Foundation

// This holds data needed for alarm creation 
struct CreateAlarmRequestor{
    let time:Date
    let isEnabled:Bool
}

struct CreateAlarmRequestFactory:RequestFactoryProtocol{
    typealias Input = (time:Date,isEnabled:Bool)
    typealias Output = CreateAlarmRequestor
    func build(input: Input) -> Output {
        CreateAlarmRequestor(time: input.time, isEnabled: input.isEnabled)
    }
}
