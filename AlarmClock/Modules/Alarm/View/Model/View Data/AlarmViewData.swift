//
//  AlarmViewData.swift
//  AlarmClock
//
//  Created by Linkon Sid on 28/1/23.
//

import Foundation

// This holds data needed to view alarm list on screen
struct AlarmViewData:Identifiable{
    var id:UUID
    var time:String
    var isEnabled:Bool
}
