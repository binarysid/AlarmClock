//
//  AlarmPresenter.swift
//  HugeClock
//
//  Created by Linkon Sid on 29/1/23.
//

import Foundation

// The presenter gets model data from interactor, converts them to presentable format and send it to the view
struct AlarmPresenter {
    weak var view:AlarmViewOutput!
    func getViewData(from data: [Alarm])->[AlarmViewData]{
        return data.map{
            let time = $0.time.getTime(with: "hh:mm")
            return AlarmViewData(id: $0.id, time: time, isEnabled: $0.isEnabled)
        }
    }
}

extension AlarmPresenter:AlarmPresentable{
    
    func presentAlarmUpdateSuccess() {
        view.showUpdateAlert(with: AppConstants.Alarm.ErrorMessage.AlarmUpdateSuccess)
    }
    
    func presentAlarmUpdateFail() {
        view.showUpdateAlert(with: AppConstants.Alarm.ErrorMessage.AlarmUpdateFail)
    }
    
    func presentAlarmCreationSuccess() {
        view.showUpdateAlert(with: AppConstants.Alarm.ErrorMessage.AlarmCreateSuccess)
    }
    
    func presentAlarmCreationFail() {
        view.showUpdateAlert(with: AppConstants.Alarm.ErrorMessage.AlarmCreateFail)
    }
    
    func presentAlarmList(data: [Alarm]) {
        view.showAlarmList(data: getViewData(from: data))
    }
    
    func presentAlarmDeletionSuccess(){
        
    }
    
    func presentAlarmDeletionFail(){
        
    }
    
    func showLoading() {
        view.showLoading()
    }
    
    func hideLoading() {
        view.hideLoading()
    }
    func updateViewData(with request: UpdateAlarmRequestor){
        view.updateData(with: request)
    }
}
