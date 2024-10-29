//
//  AppDelegate.swift
//  Articles
//
//  Created by Gursewak Singh on 28/10/24.
//

import UIKit
import Alamofire
import AlamofireNetworkActivityIndicator
import XCGLogger
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let log = XCGLogger.default
    var reachability: Reachability?

static let shared = AppDelegate()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkManager.shared.startNetworkReachabilityObserver()

        log.debug("app is started")
        log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true)

        
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
                NetworkActivityIndicatorManager.shared.startDelay = 0.1  // Optional delay before the indicator appears

        return true
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
    func setupNetworkReachability() {
        self.reachability = Reachability.init()
        do {
            try self.reachability?.startNotifier()
        }
        catch {
            print(error)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: ReachabilityChangedNotification,object: reachability)
    }
    
    
    @objc func reachabilityChanged(note: NSNotification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let reachability = note.object as! Reachability
            
            if reachability.isReachable {
              
                
                if reachability.isReachableViaWiFi {
                    print("Reachable via WiFi")
                }
                else {
                    print("Reachable via Cellular")
                }
            }
            else {
                print("Network not reachable")
//                self.openNetworkDialog()
            }
        }
    }

}


