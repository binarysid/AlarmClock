//
//  TimerInputValidator.swift
//  HugeClock
//
//  Created by Linkon Sid on 26/1/23.
//

// Validates user input
final class TimerInputValidator:TimerInputValidatorProtocol{
    func validate(hour:String,minute:String,second:String, upto hourLimit:Int)->TimerValidDataFormat?{
        guard let hours = Int(hour), let minutes = Int(minute),
              let seconds = Int(second) else{return nil}
        guard hours<=hourLimit, minutes<=60, seconds<=60 else{return nil}
        let totalGivenSeconds = getTotalSecondsFrom(hour: hours, minute: minutes, second: seconds)
        let totalExpectedSeconds = getTotalSecondsFrom(hour: hourLimit, minute: 0, second: 0)
        guard totalGivenSeconds<=totalExpectedSeconds else{return nil}
        return (hours, minutes, seconds)
    }
    func getTotalSecondsFrom(hour:Int,minute:Int,second:Int)->Int{
        return (hour*3600)+(minute*60)+second
    }
    
}
