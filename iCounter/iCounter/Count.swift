//
//  Count.swift
//  iCounter
//
//  Created by Jason Claxton on 8/14/17.
//  Copyright © 2017 Jason Claxton. All rights reserved.
//

import Foundation

class Count: NSObject, NSCoding  {

    var timeStamp: String?
    var savedCount: Int?
    
    init(TimeStamp: String?, SavedCount: Int){
        self.timeStamp = TimeStamp
        self.savedCount = SavedCount
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(TimeStamp: "No Time Saved", SavedCount: 0)
        timeStamp = aDecoder.decodeObject(forKey:"Time") as? String
        savedCount = aDecoder.decodeObject(forKey:"Count") as? Int
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(timeStamp, forKey:"Time")
        aCoder.encode(savedCount, forKey:"Count")
    }

    
}
