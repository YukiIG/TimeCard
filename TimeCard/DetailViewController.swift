//
//  DetailViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/03/04.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    var userId: String!
    var startTime: NSDate!
    var endTime: NSDate!
    var workTime: Int = 0
    @IBOutlet var idLabel: UILabel!
    let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let companyId: String! = defaults.stringForKey("companyId")
        
        let query = PFQuery(className: "TimeData")
            query.whereKey("userId", equalTo: userId)
            query.whereKey("companyId", equalTo: companyId)
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if error == nil {
                    
                    for object in objects!{
                        print(object)
                        self.startTime = object.createdAt
                        self.endTime = object.updatedAt
                        print(self.startTime)
                        
                    }
                    
                } else {
                        print(error)
                }
            }
        
    }
    
 
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let companyId: String! = defaults.stringForKey("companyId")
//        
//        func update(companyId:String!, userId: String!){
//            let query = PFQuery(className: "TimeData")
//            query.whereKey("userId", equalTo: userId)
//            query.whereKey("companyId", equalTo: companyId)
//            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//                if error == nil {
//                    
//                    for object in objects!{
//                        print(object)
//                        self.startTime = object.createdAt
//                        self.endTime = object.updatedAt
//                        print(self.startTime)
//                    }
//                    
//                } else {
//                    print(error)
//                }
//            }
//        }
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
