//
//  AlarmNotificationManager.swift
//  AlarmClock
//
//  Created by Linkon Sid on 30/1/23.
//

import SwiftUI

enum NotificationCategory:String{
    case general
}
struct AlarmNotificationManager{
    static let shared = AlarmNotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    private let delegate = LocalNotificationDelegate()
    
    init(){
        notificationCenter.delegate = delegate
    }
    func registerLocalNotification(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (isAuthorize, error) in
            if isAuthorize {
                print("succeded")
            } else {
                print("failed")
            }
        }
    }
    func createScheduleNotification(contentData:NotificationContent,trigger:DateComponents,doesRepeat:Bool){
        
        let content = UNMutableNotificationContent()
        content.title = contentData.title
        content.body = contentData.body
        content.categoryIdentifier = contentData.categoryIdentifier.rawValue
        content.userInfo = contentData.userInfo
        content.sound = UNNotificationSound.default
        let trigger = UNCalendarNotificationTrigger(dateMatching: trigger, repeats: doesRepeat)
        let request = UNNotificationRequest(identifier: contentData.id.uuidString, content: content, trigger: trigger)
        //        self.setActions()
        notificationCenter.add(request){error in
            if let error = error{
                print(error)
            }
        }
    }
    func removePendingNotification(by id:UUID){
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
    }
    func removeDeliveredNotification(by id:UUID){
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [id.uuidString])
    }
    
    //    private func setActions(){
    //        let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    //            let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
    //
    //        notificationCenter.setNotificationCategories([category])
    //    }
}

final class LocalNotificationDelegate:NSObject, UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        handleNotificationUponReceive(userInfo: userInfo)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound,.badge,.banner])
    }
    private func handleNotificationUponReceive(userInfo:[AnyHashable:Any]){
        guard let strID = userInfo["id"] as? String, let alarmID = UUID(uuidString: strID) else{return}
        let worker = AlarmDataServiceWorker()
        worker.deleteAlarm(with: AlarmRequestor.getDeleteRequest(id: alarmID), completionHandler: {result in
            switch result{
            case .success(let value):
                print("delete \(value)")
            }
        })
    }
}
