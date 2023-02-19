//
//  TimerUpdater.swift
//  HugeClock
//
//  Created by Linkon Sid on 26/1/23.
//
import Foundation
import Combine

// Core Engine for managing stopwatch remaining time
final class CountDownEngine:TimerWatchable{
    
    var publisher: PassthroughSubject<TimerValidDataFormat?, Never> = .init()
    private var endTime:Date?
    private var pauseTime:Date?
    
    func setEndTime(from totalTime:Int, to time:Date?){
        if let time = time {
            endTime = Calendar.current.date(byAdding: .second, value: totalTime, to: time)
        }
    }
    func update(){
        //        if let pauseTime = pauseTime {
        //            let pausedTimeInterval = getTimeDifference(from: pauseTime, till: Date())
        //            let timeData = getTimeData(from: pausedTimeInterval)
        //            let total = (timeData.hour*3600)+(timeData.minute*60)+timeData.second
        //            setEndTime(from: total, to: endTime)
        //            self.resetPauseInterval()
        //        }
        guard let endTime = endTime else {
            return
        }
        let timeinDiff = self.getTimeDifference(from: endTime, till: Date())
        // if the difference is less/equal zero then the time has been elapsed
        if timeinDiff <= 0 {
            self.reset()
            return
        }
        publisher.send(getTimeData(from: timeinDiff))
    }
    func reset() {
        endTime = nil
        publisher.send(nil)
    }
    func pause(){
        pauseTime = Date()
    }
}

// MARK: Business logic
extension CountDownEngine{
    private func resetPauseInterval(){
        
    }
    private func getTimeDifference(from end:Date, till  today:Date)->TimeInterval{
        end.timeIntervalSince1970 - today.timeIntervalSince1970
    }
    private func getTimeData(from interval:TimeInterval)->TimerValidDataFormat{
        
        let date = Date(timeIntervalSince1970: interval)
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        return (hour,minute,second)
    }
}
