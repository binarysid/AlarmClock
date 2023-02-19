//
//  TimerUseCase.swift
//  AlarmClock
//
//  Created by Linkon Sid on 27/1/23.
//

import Combine
import Foundation

enum TimerState{
    case Active,Paused,Suspended,Inactive
}

// This class validates data, process presentable format, monitor the stopwatch and sends update to View Model.
final class TimerCountDownUseCase:CountDownUseCaseProtocol{
    @Inject private var repository:TimerRepositoryProtocol
    @Inject private var stopWatch:TimerWatchable
    let queue: OperationQueue
    var cancellable = Set<AnyCancellable>()
    var publisher:PassthroughSubject<TimerViewData?,Never> = .init()
    private(set) var state:TimerState = .Inactive{
        didSet{
            onChange(state: state)
        }
    }
    
    init(
         queue: OperationQueue
    ) {
        self.queue = queue
    }
    
    func startTimer(){
        initializeTime()
        subscribeToStopWatch()
        invokePeriodicUpdate(by: 1)
    }
    
    func setState(state:TimerState){
        self.state = state
    }
    
    func reset(){
        stopWatch.reset()
    }
    
    func getCurrentState()->TimerState{
        state
    }
    func buildModelData(from item: TimerValidDataFormat) {
        repository.createModelData(from: item)
    }
}
extension TimerCountDownUseCase{
    
    private func onChange(state:TimerState){
        switch state {
        case .Active:
            queue.isSuspended = false
        case .Paused:
            queue.isSuspended = true
            stopWatch.pause()
        case .Suspended:
            queue.isSuspended = true
            publisher.send(nil)
        default:
            print("")
        }
    }
    
    private func initializeTime(){
        guard let totalTime = repository.getModelData()?.totalTimeInSec else{
            return
        }
        stopWatch.setEndTime(from: totalTime, to: Date())
    }
    
    private func subscribeToStopWatch(){
        stopWatch.publisher
            .receive(on: DispatchQueue.main)
            .map{[weak self] item -> TimerViewData? in
                guard let data = item else{
                    self?.state = .Suspended
                    return nil
                }
                return TimerViewData(hour:String(data.hour),minute:String(data.minute),second:String(data.second))
            }
            .sink(
                receiveValue: {[weak self] data in
                    self?.publisher.send(data)
                })
            .store(in: &cancellable)
    }
    
    private func invokePeriodicUpdate(by seconds:Int){
        queue.schedule(
            after: queue.now,
            interval: .seconds(seconds)
        ) {[weak self] in
            self?.stopWatch.update()
        }
        .store(in: &cancellable)
    }
}
