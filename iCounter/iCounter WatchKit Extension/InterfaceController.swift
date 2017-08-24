//
//  InterfaceController.swift
//  iCounter WatchKit Extension
//
//  Created by Jason Claxton on 8/13/17.
//  Copyright © 2017 Jason Claxton. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

var CList: [Count] = []

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(error)
        
    }
    fileprivate let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    override init(){
        super.init()
        session?.delegate = self
        DispatchQueue.main.async {
            self.session?.activate()
        
            //Send message to iOS App to get most recent list to update table view
            self.getCountList()
        }
     
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        //Call to get updated list
         getCountList()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //Sends Message to IOS App to retrieve data
    func getCountList(){
        let getCounts:[String:Any] = ["GetList":true]
        if let session = session, session.isReachable{
            session.sendMessage(getCounts, replyHandler: {
                replyData in
                DispatchQueue.main.async {
                    if let data = replyData["List"] as? Data{
                        NSKeyedUnarchiver.setClass(Count.self, forClassName: "Count")
                        let list = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Count]
                        CList = list
                    }
                }
                }, errorHandler: { (Error) in
                    print(Error.localizedDescription)
            })
        }
    }

}
