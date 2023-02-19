//
//  UpdateAlarmRequestor.swift
//  HugeClock
//
//  Created by Linkon Sid on 29/1/23.
//

import Foundation

// This holds data needed for alarm update/delete
struct UpdateAlarmRequestor{
    let id:UUID
    let isEnabled:Bool
}

struct UpdateAlarmRequestFactory:RequestFactoryProtocol{
    typealias Input = (id:UUID,isEnabled:Bool)
    typealias Output = UpdateAlarmRequestor
    func build(input: Input) -> Output {
        UpdateAlarmRequestor(id: input.id, isEnabled: input.isEnabled)
    }
}

struct DeleteAlarmRequestFactory:RequestFactoryProtocol{
    typealias Input = UUID
    typealias Output = UpdateAlarmRequestor
    func build(input: Input) -> Output {
        UpdateAlarmRequestor(id: input, isEnabled: false)
    }
}
