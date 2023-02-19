//
//  ClockFetchDataUseCase.swift
//  AlarmClock
//
//  Created by Linkon Sid on 11/2/23.
//

import Combine

// This holds business logic for fetching current time from repository. Responsible for communicating with data layer, process data and update the View Model
final class ClockFetchDataUseCase<T:ClockRepositoryProtocol>{
    private let repository:T
    var cancellable = Set<AnyCancellable>()
    private(set) var domainData:ContiguousArray<ClockDTO> = []
    init(repository:T){
        self.repository = repository
    }
}
extension ClockFetchDataUseCase:ClockFetchDataUseCaseProtocol{
    func fetchData()->Future<ContiguousArray<ClockDTO>,Never>{
        return Future{[unowned self] promise in
            let data = repository.fetchData(limit: 4)
            domainData = data
            promise(.success(data))
        }
    }
}
