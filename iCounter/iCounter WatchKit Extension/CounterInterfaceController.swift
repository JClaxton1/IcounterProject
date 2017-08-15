//
//  CounterInterfaceController.swift
//  iCounter
//
//  Created by Jason Claxton on 8/13/17.
//  Copyright © 2017 Jason Claxton. All rights reserved.
//

import WatchKit
import Foundation


class CounterInterfaceController: WKInterfaceController {

    var count = 0
    var math = "Add"
    
    
    
    @IBOutlet var label: WKInterfaceLabel!
    @IBOutlet var button: WKInterfaceButton!
    
    //Button Press Actions 
    //switchDirection Menu button swaps from adding numbers to removing them
    @IBAction func switchDirection() {
        switch math {
        case "Add":
            button.setBackgroundImageNamed("Exercise2")
            math = "Subtract"
            button.setTitle("-")
        default:
        button.setBackgroundImageNamed("Exercise1")
            math = "Add"
            button.setTitle("+")
        }
    }
    
    //resetMenu reset counter to zero
    @IBAction func resetMenu() {
        resetCounter()
    }
    
    @IBAction func saveCount() {
        
    }
    //Button to Add or subtract from counter
    @IBAction func addButton() {
        
        switch math {
        case "Add":
            addOne()
        default:
            subtractOne()
        }
        
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    

    //Reset Counter to Zero Switch to Add
    func resetCounter(){
        button.setBackgroundImageNamed("Exercise1")
        count = 0
        math = "Add"
        label.setText("0\(count)")
        label.setTextColor(UIColor(red: 0.8, green: 0.2, blue: 0.6, alpha: 1.0))
        button.setTitle("+")
    }

    //Handling Addition of numbers updates label and play haptic on 10 count
    func addOne(){
        count += 1
        updateColor()

        //At least Double Digit counting always
        if count < 10{
            label.setText("0\(count)")
        }else{
            label.setText("\(count)")
        }
        
        //Save Battery only provide haptic on 10s
        if count % 10 == 0 {
        WKInterfaceDevice.current().play(.click)
        }
        
    }
    
    // Handling Subtraction of numbers updates label and play haptic on Zero
    func subtractOne(){
        
        if count > 0{
            count -= 1
        }else{
            WKInterfaceDevice.current().play(.failure)
        }
        
        updateColor()
        
        if count < 10{
            label.setText("0\(count)")
        }else{
            label.setText("\(count)")
        }
        
    }
    
    
    
    //Handle Color of Counter Digits
    func updateColor(){
        if count < 25 {
            label.setTextColor(UIColor(red: 0.8, green: 0.2, blue: 0.6, alpha: 1.0))
        }else if count >= 25 && count < 50 {
            label.setTextColor(UIColor(red: 0.89, green: 0.22, blue: 0.77, alpha: 1.0))
        }else if count >= 50 && count < 75 {
            label.setTextColor(UIColor(red: 0.52, green: 0.26, blue: 0.99, alpha: 1.0))
        }else if count >= 75 && count < 100 {
            label.setTextColor(UIColor(red: 0.47, green: 0.32, blue: 0.99, alpha: 1.0))
        }else if count >= 100 && count < 125 {
            label.setTextColor(UIColor(red: 0.29, green: 0.96, blue: 0.36, alpha: 1.0))
        }else if count >= 125 && count < 150 {
            label.setTextColor(UIColor(red: 0.65, green: 0.97, blue: 0.26, alpha: 1.0))
        }else if count >= 175 && count < 200 {
            label.setTextColor(UIColor(red: 0.91, green: 0.64, blue: 0.25, alpha: 1.0))
        }else if count >= 200 && count < 225 {
            label.setTextColor(UIColor(red: 0.85, green: 0.18, blue: 0.18, alpha: 1.0))
        }
    }
    
    //Pulls Current Time
    func timestamp() -> String{
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        return(timestamp)
    }
    
    //Create SavedCount
    func save (){
        let count = Count(TimeStamp: timestamp(), SavedCount: self.count)

    }
    
    
}
