//
//  TimerViewModel.swift
//  HugeClock
//
//  Created by Linkon Sid on 26/1/23.
//

import Combine
import Foundation

// This class holds reference to domain object for data update
final class TimerViewModel:TimerViewModelProtocol {
    @Inject private var countDownUseCase:CountDownUseCaseProtocol
    var cancellable = Set<AnyCancellable>()
    @Published var viewData:TimerViewData?
    @Published var showValidationAlert = false
    let hourLimit = 4
//    init(countDownUseCase:CountDownUseCaseProtocol) {
//        self.countDownUseCase = countDownUseCase
//    }
    
    func startTimer(hour:String,minute:String,second:String){
        //validate user input before starting the stopwatch
        guard countDownUseCase.validateInput(hour:hour,minute:minute,second:second, upto: hourLimit) else{
            showValidationAlert = true
            return
        }
        countDownUseCase.setState(state: .Active)
        subscribeToChangeInDomain()
        countDownUseCase.startTimer()
    }
    
    func pauseTimer(){
        countDownUseCase.setState(state: .Paused)
    }
    
    func stopTimer(){
        countDownUseCase.reset()
    }
    
    func resumeTimer(){
        countDownUseCase.setState(state: .Active)
    }
    func getState()->TimerState{
        countDownUseCase.getCurrentState()
    }
    func getHourLimit()->Int{
        return hourLimit
    }
}

// MARK: Core Functions
extension TimerViewModel{
    private func subscribeToChangeInDomain(){
        countDownUseCase.publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveValue: {[weak self] data in
                    self?.viewData = data
            })
            .store(in: &cancellable)
    }
}
