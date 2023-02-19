//
//  ClockDataUseCase.swift
//  AlarmClock
//
//  Created by Linkon Sid on 27/1/23.
//

import Combine
import Foundation

// This class holds business logic for current time scheduler. 
final class ClockSchedulerUseCase:ClockSchedulerUseCaseProtocol {

    var updateDataPublisher: PassthroughSubject<Date, Never> = .init()
    private let queue: OperationQueue
    var cancellable = Set<AnyCancellable>()
    
    init(queue: OperationQueue){
        self.queue = queue
    }
    
    func start() {
        queue.schedule(
            after: queue.now,
            interval: .seconds(1)
        ) {[weak self] in
            guard let self = self else{return}
            self.updateDataPublisher.send(Date())
        }
        .store(in: &cancellable)
    }
}

