//
//  NetworkManager.swift
//  Articles
//
//  Created by Gursewak Singh on 30/10/24.
//

import Foundation
import UIKit
import Alamofire
class NetworkManager {
    var currentViewController: UIViewController? = nil
    static let shared = NetworkManager()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening(onUpdatePerforming: { [self] status in
            let alert = UIAlertController(title: "Alert", message: "No Internet Connection", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { actoin in
//                self.startNetworkReachabilityObserver()

                alert.dismiss(animated: true)
            }))
            switch status {
                
                            case .notReachable:
                                print("The network is not reachable")
                currentViewController?.present(alert, animated: true)

                            case .unknown :
                                print("It is unknown whether the network is reachable")
                            case .reachable(.ethernetOrWiFi):
                alert.dismiss(animated: true)

                
                print("The network is reachable over the WiFi connection")
                NotificationCenter.default.post(name: NSNotification.Name("InternetRechableNow"), object: nil)

                            case .reachable(.cellular):
                alert.dismiss(animated: true, completion: nil)
                               print("The network is reachable over the WWAN connection")
                NotificationCenter.default.post(name: NSNotification.Name("InternetRechableNow"), object: nil)

                      }
        })
    }
}
