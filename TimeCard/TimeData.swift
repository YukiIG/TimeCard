//
//  TimeData.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/02/27.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class TimeData: PFObject, PFSubclassing {
    
    @NSManaged var startTime: NSDate!
    @NSManaged var endTime: NSDate!
    @NSManaged var userId: String!
    @NSManaged var companyId: String!
    
    
    init(startTime: NSDate, endTime: NSDate, userId: String, companyId: String) {
        super.init()
        self.startTime = startTime
        self.endTime = endTime
        self.userId = userId
        self.companyId = companyId
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override class func initialize() {
        struct Static {
            static var oneceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.oneceToken) {
            self.registerSubclass()
        }
        
    }
    
    static func parseClassName() -> String {
        
        return "TimeData"
    }
    
}
