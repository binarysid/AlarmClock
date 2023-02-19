//
//  ClockContract.swift
//  AlarmClock
//
//  Created by Linkon Sid on 19/2/23.
//
import Foundation
import Combine

protocol ClockViewModelProtocol:ObservableObject {
    var viewData:ContiguousArray<ClockViewData>{get}
    func startClock()
}

protocol ClockSchedulerUseCaseProtocol{
    var updateDataPublisher:PassthroughSubject<Date,Never>{get}
    func start()
}

protocol ClockFetchDataUseCaseProtocol{
    func fetchData()->Future<ContiguousArray<ClockDTO>,Never>
}

protocol ClockRepositoryProtocol{
    func fetchData(limit:Int) -> ContiguousArray<ClockDTO>
}
