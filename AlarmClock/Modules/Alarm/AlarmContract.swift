//
//  AlarmContract.swift
//  HugeClock
//
//  Created by Linkon Sid on 15/2/23.
//
import Combine
import Foundation

protocol AlarmViewInput:ObservableObject {
    var viewData:[AlarmViewData] {get set}
    var isLoading:Bool {get set}
    func navigateToXView()
    func fetchAlarmList()
    func createAlarm(with time:Date)
    func updateAlarmWith(data:AlarmViewData)
    func deleteAlarmWith(data:AlarmViewData)
}

protocol AlarmViewOutput:AnyObject,ActivityLoadable{
    func showAlarmList(data:[AlarmViewData])
    func showUpdateAlert(with message:String)
    func updateData(with request: UpdateAlarmRequestor)
}

protocol AlarmRoutable{
    func navigateToView()
}

protocol AlarmInteractable{
    func createAlarm(with request:CreateAlarmRequestor)
    func fetchAlarm(with request:FetchAllAlarmRequestor)
    func updateAlarm(with request:UpdateAlarmRequestor)
    func deleteAlarm(with request:UpdateAlarmRequestor)
}

protocol AlarmPresentable:ActivityLoadable{
    func presentAlarmList(data:[Alarm])
    func presentAlarmUpdateSuccess()
    func presentAlarmUpdateFail()
    func presentAlarmCreationSuccess()
    func presentAlarmCreationFail()
    func presentAlarmDeletionSuccess()
    func presentAlarmDeletionFail()
    func updateViewData(with request: UpdateAlarmRequestor)
    
}
