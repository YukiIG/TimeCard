//
//  CampanyMenber.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/02/27.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class CompanyMenber: PFObject, PFSubclassing {
    
    @NSManaged var companyId: String!
    @NSManaged var userId: String!
    
    
    init(companyId: String, userId: String) {
        super.init()
        self.companyId = companyId
        self.userId = userId
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
        
        return "CompanyMember"
    }
    
}
