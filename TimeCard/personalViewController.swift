//
//  personalViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/03/04.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class personalViewController: UIViewController {
    @IBOutlet var wageLabel: UILabel!
    let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var companyId: String!
    let now = NSDate()
    var startTime: NSDate!
    var endTime: NSDate!
    var workTime: Int = 0
    var wage: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userId: String! = defaults.stringForKey("userId")
        print(userId)
        // Do any additional setup after loading the view.
        let query = PFQuery(className: "TimeData")
        query.whereKey("userId", equalTo: userId)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                
                for object in objects!{
                    print(object)
                    self.startTime = object.createdAt
                    self.endTime = object.updatedAt
                    self.companyId = object["companyId"] as! String
                    
                    print(self.companyId)
                    print("check point")

                    
                 
                                        let queryCompany = PFQuery(className: "Companies")
                                        queryCompany.whereKey("companyId", equalTo: self.companyId)
                                        queryCompany.findObjectsInBackgroundWithBlock { (companyObjects, error) -> Void in
                                            if error == nil{
                                                print(companyObjects)
                                                for companyObject in companyObjects! {
                                                    self.wage = (companyObject["hourlyWage"] as! Int)
                                                    print(self.wage)
                                                    print("self wage")
                                                }
                                                
                                            } else {
                    
                                            }
                                        }
                    

                    
                    
                    var time = Int(self.endTime.timeIntervalSinceDate(self.startTime))
                    
                    //今月の給料
                    if self.month(self.startTime) == self.month(self.now){
                        print(time)
                        print("time end")
                        self.workTime += time
                    }
                }
                
                print(self.companyId)
                print("Id check")
      //          self.wage = self.hourlyWage(self.companyId)
                
                print(self.workTime)
                print("workTime end")
                let workHour: Int = self.workTime / 3600
                let totalWage: Int = self.wage * workHour
                self.wageLabel.text = String(totalWage)
                //         print(totalWage)
                //       print(workHour)
            } else {
                print(error)
            }
        }
        
    }
    
//    func hourlyWage(companyId: String) ->Int {
//        var tmpWage: Int! = 0
//        let query = PFQuery(className: "Companies")
//        query.whereKey("companyId", equalTo: companyId)
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if error == nil {
//                print(objects)
//                for object in objects!{
//                    tmpWage = (object["hourlyWage"] as! Int)
//                    print(tmpWage)
//                    print("self wage")
//                }
//            } else {
//                
//            }
//        }
//        return tmpWage
//    }
    
    //NSDateから値を取得
    func month(date : NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp : NSDateComponents = calendar.components(
            NSCalendarUnit.Month, fromDate: date)
        return comp.month
    }
    
    func hour(date : NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        var comp : NSDateComponents = calendar.components(
            NSCalendarUnit.Hour, fromDate: date)
        return comp.month
    }
    
    
    
    
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
