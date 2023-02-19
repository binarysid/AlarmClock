//
//  AlarmNotificationWorker.swift
//  HugeClock
//
//  Created by Linkon Sid on 30/1/23.
//

import Foundation
protocol AlarmNotificationWorkerProtocol{
    func createNotification(from data:Alarm)
    func removeNotification(by id:UUID)
}
struct AlarmNotificationWorker:AlarmNotificationWorkerProtocol{
    let notificationManager = AlarmNotificationManager.shared
    
    func createNotification(from data: Alarm) {
        let content = self.buildContent(from: data)
        let trigger = self.getTriggerPoint(from: data.time)
        notificationManager.createScheduleNotification(contentData: content, trigger: trigger, doesRepeat: false)
    }
    func removeNotification(by id:UUID){
        notificationManager.removePendingNotification(by: id)
    }
}

extension AlarmNotificationWorker{
    func buildContent(from data:Alarm)->NotificationContent{
        NotificationContent(id: data.id, title: AppConstants.Alarm.NotificationMessage.Title, body: data.time.getTime(with: AppConstants.DateTimeFormat.Time), categoryIdentifier: .general, userInfo: ["id":data.id.uuidString])
    }
    func getTriggerPoint(from time:Date)->DateComponents{
        let calendar = Calendar.current
        let component = calendar.dateComponents([.hour,.minute], from: time)
        return component
    }
}
