//
//  AppDelegate.swift
//  iCounter
//
//  Created by Jason Claxton on 8/13/17.
//  Copyright © 2017 Jason Claxton. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var session: WCSession?{
        didSet{
            if let session = session{
                session.delegate = self
                session.activate()
            }
        }
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if WCSession.isSupported(){
            session = WCSession.default()
        }
        return true
    }
}
extension AppDelegate: WCSessionDelegate{
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    //recieving Data on watch Save
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        NSKeyedUnarchiver.setClass(Count.self, forClassName: "Count")
        let d = NSKeyedUnarchiver.unarchiveObject(with: messageData) as! Count
        cList.append(d)
    }
    
    //Recieving and replying to call for current list.
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {

        DispatchQueue.main.async {
            if(message["GetList"] as? Bool) != nil{
                NSKeyedArchiver.setClassName("Count", for: Count.self)
                let data = NSKeyedArchiver.archivedData(withRootObject: cList)
                replyHandler(["List":data])
            }
        }
    }
    
}

