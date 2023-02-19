//
//  AppConstants.swift
//  AlarmClock
//
//  Created by Linkon Sid on 28/1/23.
//

import Foundation

struct AppConstants{
    
    enum Common{
        static let AppTitle = "AlarmClock"
        static let SplashImage = "deskclock.fill"
    }
    struct TabItem{
        enum Icon{
            static let Alarm = "alarm"
            static let Clock = "clock"
            static let Timer = "timer"
        }
        enum TitleText{
            static let Alarm = "Alarm"
            static let Clock = "Clock"
            static let Timer = "Timer"
        }
    }
    struct Alarm{
        enum ErrorMessage{
            static let AlarmUpdateSuccess = "Alarm update succeess"
            static let AlarmUpdateFail = "Alarm update failed"
            static let AlarmCreateSuccess = "Alarm Create succeess"
            static let AlarmCreateFail = "Alarm Create failed"
        }
        enum NotificationMessage{
            static let Title = "Alarm"
        }
        enum ActionMessage{
            static let AddAlarmSectionTitle = "Add Alarm"
            static let CreateButtonTitle = "Create Alarm"
            static let TimePickerTitle = "Pick a time"
            static let SwipeDeleteTitle = "delete"
        }
    }
    struct Timer{
        enum ActionMessage{
            static let StartButtonTitle = "Start"
            static let ResumeButtonTitle = "Resume"
            static let StopButtonTitle = "Stop"
            static let AlertConfirmationButtonTitle = "Ok"
        }
        enum ErrorMessage{
            static let InvalidRangeTitle = "Invalid time range"
            static let InvalidRangeBody = { (limit:Int) -> String in return "Total time limit is \(limit) hours" }
//            static var InvalidRangeBody = {((limit:String) -> String).self
//
//            }
            
        }
    }
    enum DateTimeFormat{
        static let Time = "hh:mm"
    }
}
