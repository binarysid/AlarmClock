//
//  AlarmDataServiceWorker.swift
//  HugeClock
//
//  Created by Linkon Sid on 29/1/23.
//

import Foundation

protocol AlarmDataServiceWorkable{
    typealias UpdateResultCompletionType = (Result<Alarm,PersistenceFailure>)->Void
    func requestAlarmCreation(with request:CreateAlarmRequestor, completionHandler: @escaping UpdateResultCompletionType)
    func fetchAlarm(with request:FetchAllAlarmRequestor, completionHandler: @escaping (Result<[Alarm],PersistenceFailure>)->Void)
    func updateAlarm(with request:UpdateAlarmRequestor, completionHandler: @escaping UpdateResultCompletionType)
    func deleteAlarm(with request:UpdateAlarmRequestor, completionHandler: @escaping (Result<Bool,Never>)->Void)
}

// Worker communicates with the repository for data, process if necessary and sends it back to interactor
struct AlarmDataServiceWorker:AlarmDataServiceWorkable{
    
    @Inject
    private var repository:AlarmRepositoryProtocol
    
    func requestAlarmCreation(with request: CreateAlarmRequestor, completionHandler: @escaping UpdateResultCompletionType) {
        
        repository.createAlarm(request: request, completionHandler: {result in
            switch result{
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func fetchAlarm(with request: FetchAllAlarmRequestor, completionHandler: @escaping (Result<[Alarm], PersistenceFailure>) -> Void) {
        
        repository.fetchAlarmList(request: request, completionHandler: {result in
            switch result{
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func updateAlarm(with request: UpdateAlarmRequestor, completionHandler: @escaping UpdateResultCompletionType) {
        
        repository.updateAlarm(with: request, completionHandler: {result in
            switch result{
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
    
    func deleteAlarm(with request: UpdateAlarmRequestor, completionHandler: @escaping (Result<Bool,Never>)->Void) {
        
        repository.deleteAlarm(with: request, completionHandler: {result in
            switch result{
            case .success(let value):
                completionHandler(.success(value))
            }
        })
    }
    
}
