//
//  MyICountInterfaceController.swift
//  iCounter
//
//  Created by Jason Claxton on 8/23/17.
//  Copyright © 2017 Jason Claxton. All rights reserved.
//

import WatchKit
import Foundation



class MyICountInterfaceController: WKInterfaceController {

    @IBOutlet var myTable: WKInterfaceTable!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print("current count is: \(CList.count)")
        // Configure interface objects here.
    }
    
    override func didAppear() {
        print("current count is: \(CList.count)")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("current count is: \(CList.count)")
        loadtable()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadtable(){
        // Set Rows Equal to Array count
        myTable.setNumberOfRows(CList.count, withRowType: "Row")
        
        //Setup each row enumerating through array
        for (index, count) in CList.enumerated(){
            if let controller = myTable.rowController(at: index) as?  RowController{
                
                controller.count.setText("\(count.savedCount!)")
                controller.date.setText(count.timeStamp!)
                
            }
        }
    }

    //Sends Selected Count through Segue to count controller
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        let context:[String:Any] = ["Count" :CList[rowIndex]]
        return context
    }
    
    
}
