//
//  Utils.swift
//  LiftWeights
//
//  Created by Andrea on 15/06/22.
//

import Foundation
import UserNotifications

class Utils {
    
    static func formatted(input: Float) -> String {
        let res = String(format: "%.1f", input)
        return res
    }
    
    static func createNotification(title: String, subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "LiftWeights", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.badge, .banner, .sound])
        }
    }
}
