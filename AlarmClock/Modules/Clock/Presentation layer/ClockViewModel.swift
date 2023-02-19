//
//  TimeViewModel.swift
//  AlarmClock
//
//  Created by Linkon Sid on 25/1/23.
//

import Combine
import Foundation

// This class act as mediator between View and Domain Layer. View only communicates with this layer.
final class ClockViewModel:ClockViewModelProtocol {
    @Published var viewData:ContiguousArray<ClockViewData> = []
    @Inject
    private var schedulerUseCase:ClockSchedulerUseCaseProtocol
    @Inject
    private var fetchListUseCase:ClockFetchDataUseCaseProtocol
    var cancellable = Set<AnyCancellable>()
    var domainObj:ContiguousArray<ClockDTO> = []{
        didSet{
            self.viewData = ContiguousArray(domainObj.map{
                ClockViewData(id: $0.id, time: self.getTimeFrom(date: Date() , timeZone: $0.timezone), timezone: $0.local)
            })
        }
    }
    
    func startClock() {
        getData()
        startTimeUpdater()
    }
    
    func startTimeUpdater(){
        schedulerUseCase.start()
        schedulerUseCase.updateDataPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] data in
                guard let self = self else{return}
                self.updateViewDataWith(date: data)
            })
            .store(in: &cancellable)
    }
    
    func getData(){
        fetchListUseCase.fetchData()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] data in
                guard let self = self else{return}
                self.domainObj = data
            })
            .store(in: &cancellable)
    }

}

// MARK: Presentables
extension ClockViewModel{
    func updateViewDataWith(date:Date){
        for i in 0..<viewData.count{
            if let timezone = TimeZone(identifier: viewData[i].id){ // id comes from timezone identifiers. so it should be converted vice-versa
                viewData[i].time = getTimeFrom(date: date, timeZone: timezone)
            }
        }
    }
                                        
    func getTimeFrom(date:Date,timeZone:TimeZone)->String{
        date.getTime(with: timeZone, format: "hh:mm", am: "am", pm: "pm")
    }
}
