//
//  TimeCardViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/03/02.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class TimeCardViewController: UIViewController {
    @IBOutlet var userId: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Paese データ挿入
    func create(companyId: String!, userId: String!){
        let userData: PFObject = PFObject(className: "TimeData")
        userData.setObject(companyId, forKey: "companyId")
        userData.setObject(userId, forKey: "userId")
        userData.setObject(1, forKey: "start")
        userData.setObject(0, forKey: "end")
        userData.saveInBackground()
    }

    //Parse データ更新
    func update(companyId:String!, userId: String!){
        let query = PFQuery(className: "TimeData")
        query.whereKey("userId", equalTo: userId)
        query.whereKey("companyId", equalTo: companyId)
        query.whereKey("end", equalTo: 0)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects!{
                    object["end"] = 1
                    object.saveInBackgroundWithBlock{ (success, error) -> Void in
                        if success {
                            print("OK")
                        } else {
                            print("Error")
                        }
                    }
                }
            } else {
                print(error)
            }
    }
    }

    //アラート
    func alert(titleWord: String, messageWord: String){
        let alertController = UIAlertController(title: titleWord, message: messageWord, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //入社ボタン
    @IBAction func startTime(){
        let user = userId.text
        let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let companyId: String! = defaults.stringForKey("companyId")
        
        
        if user != "" {
            
            create(companyId, userId: user)
//            alert("出社", messageWord: "頑張って下さい！")
            performSegueWithIdentifier("goStartPage", sender: nil)
        } else {
            alert("エラー", messageWord: "ユーザーIDを入力してください")
        }
    }

    //退社ボタン
    @IBAction func endTime(){
        let user = userId.text
        let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let companyId: String! = defaults.stringForKey("companyId")
        
        
        if user != "" {
            update(companyId, userId: user)
//            alert("退社", messageWord: "お疲れ様でした！")
            performSegueWithIdentifier("goEndPage", sender: nil)
        } else {
            alert("エラー", messageWord: "ユーザーIDを入力してください")
        }
       
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
