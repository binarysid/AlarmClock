//
//  TimerDataPresenter.swift
//  HugeClock
//
//  Created by Linkon Sid on 26/1/23.
//

// This class prepares data for domain operation and view purpose
final class TimerDataProcessor:TimerDataProcessorProtocol{
    private var data:TimerModelData?
    
    func createModelData(from item: TimerValidDataFormat){
        data = TimerModelData(hour: item.hour, minute: item.minute, second: item.second,totalTimeInSec:getTotalSecondsFrom(hour: item.hour, minute: item.minute, second: item.second))
    }
    func updateModelData(from item: TimerValidDataFormat) {
        data?.hour = item.hour
        data?.minute = item.minute
        data?.second = item.second
    }
    func getModelData()->TimerModelData?{
        return data
    }
}

// MARK: calculations
extension TimerDataProcessor{
    func getTotalSecondsFrom(hour:Int,minute:Int,second:Int)->Int{
        return (hour*3600)+(minute*60)+second
    }
    
}
