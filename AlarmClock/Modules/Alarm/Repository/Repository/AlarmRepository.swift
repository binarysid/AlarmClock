//
//  AlarmRepository.swift
//  HugeClock
//
//  Created by Linkon Sid on 28/1/23.
//

import CoreData
import Combine

protocol AlarmRepositoryProtocol{
    func createAlarm(request:CreateAlarmRequestor, completionHandler: @escaping  (Result<Alarm,PersistenceFailure>)->Void)
    
    func fetchAlarmList(request:FetchAllAlarmRequestor, completionHandler: @escaping (Result<[Alarm],PersistenceFailure>)->Void)
    func updateAlarm(with request:UpdateAlarmRequestor, completionHandler: @escaping (Result<Alarm,PersistenceFailure>)->Void)
    func deleteAlarm(with request:UpdateAlarmRequestor, completionHandler: @escaping (Result<Bool,Never>)->Void)
}
// Repository talks to datasource for CRUD operation
final class AlarmRepository:AlarmRepositoryProtocol {
    
    @Inject
    private var dataSource:AlarmLocalDataSourceProtocol
    private var cancellable = Set<AnyCancellable>()
    
    func fetchAlarmList(request: FetchAllAlarmRequestor, completionHandler: @escaping (Result<[Alarm], PersistenceFailure>) -> Void) {
        
        dataSource.fetchList(request: request)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion,error == .NoDataFound{
                    completionHandler(.failure(error))
                }
            }, receiveValue: {data in
                completionHandler(.success(data))
            })
            .store(in: &cancellable)
    }
    
    func createAlarm(request:CreateAlarmRequestor, completionHandler: @escaping (Result<Alarm, PersistenceFailure>) -> Void) {
        
        dataSource.create(request: request)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion,error == .FailedToSave{
                    completionHandler(.failure(error))
                }
            }, receiveValue: {data in
                completionHandler(.success(data))
            })
            .store(in: &cancellable)
    }
    
    func updateAlarm(with request: UpdateAlarmRequestor, completionHandler: @escaping (Result<Alarm, PersistenceFailure>) -> Void) {
        
        // for updating the data we need to fetch the core data object from db first and then perform update on that particular object
        dataSource.fetchEntityBy(request: request)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion,error == .FailedToSave{
                    completionHandler(.failure(error))
                }
            }, receiveValue: {[weak self] data in
                guard let item = data.first, let self = self else{
                    completionHandler(.failure(.NoDataFound))
                    return
                }
                self.dataSource.update(item:item, request: request)
                    .sink(receiveCompletion: {completion in
                        if case .failure(let error) = completion,error == .FailedToSave{
                            completionHandler(.failure(error))
                        }
                    }, receiveValue: {data in
                        completionHandler(.success(data))
                    })
                    .store(in: &self.cancellable)
            })
            .store(in: &cancellable)
    }
    
    func deleteAlarm(with request: UpdateAlarmRequestor, completionHandler: @escaping (Result<Bool, Never>) -> Void) {
        // for deleting the data we need to fetch the core data object from db first and then perform deletion on that object
        dataSource.fetchEntityBy(request: request)
            .sink(receiveCompletion: {completion in
                if case .failure(let error) = completion,error == .FailedToSave{
                    completionHandler(.success(false))
                }
            }, receiveValue: {[weak self] data in
                guard let item = data.first, let self = self else{
                    completionHandler(.success(false))
                    return
                }
                self.dataSource.delete(item:item, request: request)
                    .sink(receiveCompletion: {completion in
                        if case .failure(let error) = completion,error == .FailedToSave{
                            completionHandler(.success(false))
                        }
                    },
                          receiveValue: {value in
                        completionHandler(.success(value))
                    })
                    .store(in: &self.cancellable)
            })
            .store(in: &cancellable)
    }
}
