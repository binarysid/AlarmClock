//
//  ClockDataSource.swift
//  HugeClock
//
//  Created by Linkon Sid on 27/1/23.
//

import Foundation


protocol ClockDataSource{
    func getData()->[TimeZoneData]
}
