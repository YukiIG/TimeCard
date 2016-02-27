//
//  Users.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/02/25.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class Users: PFObject, PFSubclassing {
    
    @NSManaged var userId: String!
    @NSManaged var userName: String!
    @NSManaged var password: String!
    
    
    init(userId: String, userName: String, password: String) {
        super.init()
        self.userId = userId
        self.userName = userName
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
        
        return "Users"
    }
    
}
