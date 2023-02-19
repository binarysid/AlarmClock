//
//  AlarmRequestManager.swift
//  HugeClock
//
//  Created by Linkon Sid on 26/1/23.
//
import Foundation

// This creates request factory to pass from view to interactor to perform operations
struct AlarmRequestor {
    static func getCreateRequest(time:Date,isEnabled:Bool)->CreateAlarmRequestor{
        RequestFactory.create(CreateAlarmRequestFactory(), (time,isEnabled))
    }
    static func getFetchAllRequest()->FetchAllAlarmRequestor{
        RequestFactory.create(FetchAlarmRequestFactory(), PersistenceService.Entity.AlarmList.FetchRequest)
    }
    static func getUpdateRequest(id:UUID, isEnabled:Bool)->UpdateAlarmRequestor{
        RequestFactory.create(UpdateAlarmRequestFactory(), (id,isEnabled))
    }
    static func getDeleteRequest(id:UUID)->UpdateAlarmRequestor{
        RequestFactory.create(DeleteAlarmRequestFactory(), id)
    }
}

