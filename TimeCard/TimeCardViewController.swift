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

    func create(companyId: String!, userId: String!, key: String!){
        let userData: PFObject = PFObject(className: "TimeData")
        userData.setObject(companyId, forKey: "companyId")
        userData.setObject(userId, forKey: "userId")
        userData.setObject(1, forKey: key)
        userData.saveInBackground()
    }

    func alert(titleWord: String, messageWord: String){
        let alertController = UIAlertController(title: titleWord, message: messageWord, preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func startTime(){
        let user = userId.text
        let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let companyId: String! = defaults.stringForKey("companyId")
        
        
        if user != "" {
            
            create(companyId, userId: user, key: "start")
//            alert("出社", messageWord: "頑張って下さい！")
            performSegueWithIdentifier("goStartPage", sender: nil)
        } else {
            alert("エラー", messageWord: "ユーザーIDを入力してください")
        }
    }

    @IBAction func endTime(){
        let user = userId.text
        let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let companyId: String! = defaults.stringForKey("companyId")
        
        
        if user != "" {
            create(companyId, userId: user, key: "end")
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
