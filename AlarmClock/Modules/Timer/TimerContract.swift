//
//  TimerContract.swift
//  AlarmClock
//
//  Created by Linkon Sid on 19/2/23.
//

import Foundation
import Combine

typealias TimerValidDataFormat = (hour:Int,minute:Int,second:Int)

protocol TimerViewModelProtocol:ObservableObject {
    var viewData:TimerViewData? {get}
    var showValidationAlert:Bool {get set}
    func startTimer(hour:String,minute:String,second:String)
    func pauseTimer()
    func stopTimer()
    func resumeTimer()
    func getState()->TimerState
    func getHourLimit()->Int
}

protocol CountDownUseCaseProtocol{
    var publisher:PassthroughSubject<TimerViewData?,Never>{get}
    func startTimer()
    func setState(state:TimerState)
    func reset()
    func getCurrentState()->TimerState
    func buildModelData(from item: TimerValidDataFormat)
}

protocol TimerWatchable{
    var publisher: PassthroughSubject<TimerValidDataFormat?, Never>{get}
    func setEndTime(from totalTime:Int, to time:Date?)
    func update()
    func reset()
    func pause()
}

protocol TimerRepositoryProtocol{
    func createModelData(from item: TimerValidDataFormat)
    func updateModelData(from item:TimerValidDataFormat)
    func getModelData()->TimerModelData?
}

protocol TimerInputValidatorUseCaseProtocol{
    func validate(hour:String,minute:String,second:String, upto hourLimit:Int)->TimerValidDataFormat?
}
