//
//  TimeZoneData.swift
//  HugeClock
//
//  Created by Linkon Sid on 10/2/23.
//

import Foundation

typealias TimeZoneData = String

extension TimeZoneData{
    func toDomainObj()->ClockDTO?{
        guard let timeZone = TimeZone(identifier: self),
              let gmtValue = timeZone.localizedName(for: .standard, locale: nil),
              let locale = timeZone.localizedName(for: .standard, locale: .current) else
              {return nil}
        
        return ClockDTO(id:self,timezone: timeZone,local:locale,gmt: gmtValue)
    }
}
