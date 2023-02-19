//
//  AlarmInteractor.swift
//  AlarmClock
//
//  Created by Linkon Sid on 28/1/23.
//

import Foundation


// This class act as the brain of the domain. holds all the connection from view and presenter. this also delegates tasks to the worker
final class AlarmInteractor {
    // all dependencies are Injected from DIContainer class
    @Inject
    var dataServiceWorker:AlarmDataServiceWorkable
    @Inject
    var notificationWorker:AlarmNotificationWorkerProtocol
    var presenter:AlarmPresentable!
    
}

extension AlarmInteractor:AlarmInteractable{
    func createAlarm(with request: CreateAlarmRequestor) {
        self.presenter.showLoading()
        dataServiceWorker.requestAlarmCreation(with: request, completionHandler: {[weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let data):
                self.notificationWorker.createNotification(from: data) // enable local notification for each alarm
                self.presenter.presentAlarmCreationSuccess()
                self.fetchAlarm(with: AlarmRequestor.getFetchAllRequest())
            case .failure(_):
                self.presenter.presentAlarmCreationFail()
            }
            
        })
    }
    
    func fetchAlarm(with request: FetchAllAlarmRequestor) {
        self.presenter.showLoading()
        dataServiceWorker.fetchAlarm(with: request, completionHandler: {[weak self] result in
            guard let self = self else{return}
            self.presenter.hideLoading()
            switch result{
            case .success(let data):
                self.presenter.presentAlarmList(data: data)
            case .failure(let error):
                print(error.errorDescription)
            }
        })
    }
    
    func updateAlarm(with request: UpdateAlarmRequestor) {
        self.dataServiceWorker.updateAlarm(with: request, completionHandler: {[weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let data):
                // toggle local notification after each update
                if data.isEnabled{
                    self.notificationWorker.createNotification(from: data)
                }
                else{// if alarm disabled then remove notification
                    self.notificationWorker.removeNotification(by: data.id)
                }
            case .failure(_):
                self.presenter.presentAlarmUpdateFail()
                self.fetchAlarm(with: AlarmRequestor.getFetchAllRequest())
            }
        })
    }
    
    func deleteAlarm(with request: UpdateAlarmRequestor) {
        self.presenter.showLoading()
        dataServiceWorker.deleteAlarm(with: request, completionHandler: {[weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let value):
                self.fetchAlarm(with: AlarmRequestor.getFetchAllRequest())
                if value{ // if deletion success then remove local notification
                    self.presenter.presentAlarmDeletionSuccess()
                    self.notificationWorker.removeNotification(by: request.id)
                }
                else{
                    self.presenter.presentAlarmDeletionFail()
                }
            }
        })
    }
}
