//
//  AppDelegate.swift
//  Grade-Calculator
//
//  Created by Hower Chen on 2020/5/23.
//  Copyright © 2020 Hower Chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let writePath = AppDelegate.getDocumentsDirectory().appendingPathComponent("grades.json")
        if !FileManager.default.fileExists(atPath: writePath.path) {
            print("No file exist! Writing file!")
            let subjectJSONURL = Bundle.main.url(forResource: "grades", withExtension: "json")!
            let content = try! Data(contentsOf: subjectJSONURL)
            do {
                try content.write(to: writePath)
            } catch {
                print("\(error)")
                abort()
            }
        }
        
        return true
    }
    
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //print (paths[0].absoluteString)
        return paths[0]
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

