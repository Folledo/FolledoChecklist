//
//  AppDelegate.swift
//  FolledoChecklist
//
//  Created by Samuel Folledo on 2/20/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

import UIKit
import UserNotifications //p.356

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate { //p.359 this makes the AppDelegate the delegate for UNUserNotificationCenter

    var window: UIWindow?

    let dataModel = DataModel() //p.312

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //p.313 this finds AllListsViewController by looking in the storyboard (as before) and then sets its dataModel property. Now All Lists screen can access the array of Checklist objects again
        let navigationController = window!.rootViewController as! UINavigationController //p.313
        let controller = navigationController.viewControllers[0] as! AllListsViewController //p.313
        controller.dataModel = dataModel //p.313
        
        let center = UNUserNotificationCenter.current() //p.357
        center.delegate = self //p.359 tell UNUserNotificationCenter that AppDelegate is now its delegate
/* //THIS IS FOR TESTING IF LOCAL USERNOTIFICATION WORKS
        center.requestAuthorization(options: [UNAuthorizationOptions.alert, UNAuthorizationOptions.sound]) { (granted, error) in //you can also simply write .ALERT, .SOUND in the array //p.357 u tell iOS that the app wishes to send notif of type "alert" with a sound effect.
            if granted { //p.357
                print("We have permission for Local User Notification") //p.357
            } else { //p.357
                print("Permission Denied For User Notification") //p.357
            } //p.357
        }
        
        
        let content = UNMutableNotificationContent()//p.358
        content.title = "Hello" //p.358
        content.body = "I am a local notification" //p.358
        content.sound = UNNotificationSound.default() //p.358
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) //p.358 timeInterval 10 will fire exactly 10 seconds after app has started and while app is not currently active
        let request = UNNotificationRequest(identifier: "MyNotification", content: content, trigger: trigger) //p.358
        center.add(request, withCompletionHandler: nil) //p.358
        
        center.delegate = self //p.359 tell UNUserNotificationCenter that AppDelegate is now its delegate
 */
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        saveData() //p.309
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveData() //p.309
    }

    func saveData() { //p.307 Having the saveData method here will let you save the data only if application terminates or enter the background
        dataModel.saveChecklist()
/* p.307 but simplified in p.312
        let navigationController = window!.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! AllListsViewController
        controller.saveChecklist()
 */
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) { //p.359 This method will invoked when the local notification is posted and the app is still running. You wont do anythinf here except log a message to the debug pane
        print("Received local notification \(notification)") //p.359
    }
    
    
}

