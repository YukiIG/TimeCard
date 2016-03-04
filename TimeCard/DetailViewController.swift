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
    let now = NSDate()
    var startTime: NSDate!
    var endTime: NSDate!
    var workTime: Int = 0
    var wage: Int!
    @IBOutlet var hourLabel: UILabel!
    @IBOutlet var wageLabel: UILabel!
    let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let companyId: String! = defaults.stringForKey("companyId")
        

//                let queryWage = PFQuery(className: "Companies")
//                queryWage.whereKey("companyId", equalTo: companyId)
//                queryWage.findObjectsInBackgroundWithBlock { (wageObjects, error) -> Void in
//                    if error == nil {
//                        for wageObject in wageObjects!{
//                            self.wage = wageObject["hourlyWage"] as! Int
//                            print(self.wage)
//                            print("wage end")
//                        }
//                    } else {
//                        print("error")
//                    }
//                }

        
        
        let query = PFQuery(className: "TimeData")
            query.whereKey("userId", equalTo: userId)
            query.whereKey("companyId", equalTo: companyId)
            query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if error == nil {
                    
                    for object in objects!{
                        print(object)
                        self.startTime = object.createdAt
                        self.endTime = object.updatedAt
                        print(self.hour(self.startTime))
                        print(self.hour(self.now))
                        var time = Int(self.endTime.timeIntervalSinceDate(self.startTime))

                        //今月の給料
                        if self.month(self.startTime) == self.month(self.now){
                            print(time)
                            print("time end")
                        self.workTime += time
                        }
                    }
                    
                    let queryWage = PFQuery(className: "Companies")
                    queryWage.whereKey("companyId", equalTo: companyId)
                    queryWage.findObjectsInBackgroundWithBlock { (wageObjects, error) -> Void in
                        if error == nil {
                            for wageObject in wageObjects!{
                                self.wage = wageObject["hourlyWage"] as! Int
                                print(self.wage)
                                print("wage end")
                                print(self.workTime)
                                print("workTime end")
                                let workHour: Int = self.workTime / 3600
                                self.hourLabel.text = String(workHour)
                                let totalWage: Int = self.wage * workHour
                                self.wageLabel.text = String(totalWage)
                                print(totalWage)
                                print(workHour)

                            }
                        } else {
                            print("error")
                        }
                    }

                    
                    
                } else {
                        print(error)
                }
            }



//　なぜかworkTimeが0になる
//        print(workTime)
//        let workHour: Int = workTime
//        print(workHour)
//        let totalWage: Int = wage * workHour
//        print(totalWage)
//        hourLabel.text = String(workTime)
//        wageLabel.text = String(totalWage)
    }
 
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
    
    //戻る
    @IBAction func back(){
        self.navigationController?.popViewControllerAnimated(true)
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
