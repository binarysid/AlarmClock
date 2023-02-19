//
//  AlarmViewModel.swift
//  HugeClock
//
//  Created by Linkon Sid on 29/1/23.
//

import Combine
import Foundation

final class AlarmController {
    @Published var viewData:[AlarmViewData] = []
    @Published var isLoading:Bool = true // toggle activity indicator
    var interactor:AlarmInteractable!
    var router:AlarmRoutable
    init(router:AlarmRoutable) {
        self.router = router
    }
}

extension AlarmController:AlarmViewInput{
    func fetchAlarmList() {
        interactor.fetchAlarm(with: AlarmRequestor.getFetchAllRequest())
    }
    
    func navigateToXView() {
        router.navigateToView()
    }

    func createAlarm(with time:Date){
        let request =  AlarmRequestor.getCreateRequest(time: time, isEnabled: true)
        interactor.createAlarm(with: request)
    }
    func updateAlarmWith(data:AlarmViewData){
        interactor.updateAlarm(with: AlarmRequestor.getUpdateRequest(id: data.id, isEnabled: data.isEnabled))
    }
    func deleteAlarmWith(data:AlarmViewData){
        interactor.deleteAlarm(with: AlarmRequestor.getDeleteRequest(id: data.id))
    }
}

extension AlarmController:AlarmViewOutput{
    func showLoading() {
        isLoading = true
    }
    
    func hideLoading() {
        isLoading = false
    }
    
    func showAlarmList(data: [AlarmViewData]) {
        self.viewData = data
    }
    
    func showUpdateAlert(with message: String) {
        
    }
    func updateData(with request: UpdateAlarmRequestor){
        if let index = viewData.firstIndex(where: {$0.id == request.id})
        {
            viewData[index].isEnabled = request.isEnabled
        }
    }
}
