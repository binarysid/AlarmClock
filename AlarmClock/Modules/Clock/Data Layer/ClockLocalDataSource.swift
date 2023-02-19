//
//  File.swift
//  HugeClock
//
//  Created by Linkon Sid on 27/1/23.
//

import Foundation

final class ClockLocalDataSource:ClockDataSource{
    func getData() -> [TimeZoneData] {
        var data:[TimeZoneData] = [TimeZone.current.identifier]
        var zones = TimeZone.knownTimeZoneIdentifiers
        zones.remove(at: 0)
        data += zones
        return data
    }
}
