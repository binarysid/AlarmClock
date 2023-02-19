//
//  FetchAllAlarmRequestor.swift
//  HugeClock
//
//  Created by Linkon Sid on 29/1/23.
//

import Foundation

// This holds data needed for alarm fetch
struct FetchAllAlarmRequestor{
    let item: PersistenceService.Entity.AlarmList.RequestType
}

struct FetchAlarmRequestFactory:RequestFactoryProtocol{
    func build(input: Input) -> Output {
        return FetchAllAlarmRequestor(item: PersistenceService.Entity.AlarmList.FetchRequest)
    }
    typealias Input = PersistenceService.Entity.AlarmList.RequestType
    typealias Output = FetchAllAlarmRequestor
    
}
