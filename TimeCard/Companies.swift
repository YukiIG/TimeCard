//
//  Campanies.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/02/27.
//  Copyright © 2016年 yuki. All rights reserved.
//


import UIKit
import Parse

class Companies: PFObject, PFSubclassing {
    
    @NSManaged var companyId: String!
    @NSManaged var companyName: String!
    @NSManaged var password: String!
    
    
    init(companyId: String, companyName: String, password: String) {
        super.init()
        self.companyId = companyId
        self.companyName = companyName
        self.password = password
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
        
        return "Companies"
    }
    
}

