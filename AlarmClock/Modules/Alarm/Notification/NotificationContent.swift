//
//  NotificationContent.swift
//  AlarmClock
//
//  Created by Linkon Sid on 30/1/23.
//

import Foundation

// This is the content that the user will see on the notification tray when app is in background
struct NotificationContent{
    let id:UUID
    let title:String
    let body:String
    let categoryIdentifier:NotificationCategory
    let userInfo:[String:Any]
}
