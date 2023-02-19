//
//  HugeClockApp.swift
//  HugeClock
//
//  Created by Linkon Sid on 24/1/23.
//

import SwiftUI

@main
struct HugeClockApp: App {
    init(){
        AlarmNotificationManager.shared.registerLocalNotification()
    }
    var body: some Scene {
        WindowGroup {
            SplashView()
//            AlarmViewConfigurator().configure()
//            ClockViewConfigurator().configure()
//            TimerViewConfigurator().configure()
        }
    }
    
}
