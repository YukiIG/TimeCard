//
//  ViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/02/23.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    @IBOutlet var idForm: UITextField!
    @IBOutlet var passForm: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ud = NSUserDefaults.standardUserDefaults()

        //自動ログイン
        if ud.stringForKey("userId") != nil {
            performSegueWithIdentifier("toMyPage", sender: nil)
        } else if ud.objectForKey("companyId") as? String != nil {
            performSegueWithIdentifier("toCompanyPage", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Login(){
        let userId: String! = idForm.text
        let password: String! = passForm.text
        let ud = NSUserDefaults.standardUserDefaults()

        let query = PFQuery(className: "Users")
        query.whereKey("userId", equalTo: userId)
        query.whereKey("password", equalTo: password)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                ud.setObject(userId, forKey: "userId")
                ud.setObject(password, forKey: "password")
                ud.synchronize()
                self.performSegueWithIdentifier("toMyPage", sender: nil)
            } else {
                let alertController = UIAlertController(title: "エラー", message: "ユーザーIDかパスワードが違います", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func companyLogin(){
        let companyId: String! = idForm.text
        let password: String! = passForm.text
        let ud = NSUserDefaults.standardUserDefaults()

        let query = PFQuery(className: "Companies")
        query.whereKey("companyId", equalTo: companyId)
        query.whereKey("password", equalTo: password)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                if let dataObjects: [PFObject] = objects {
                for dataObject in dataObjects {
                    if password == dataObject["password"] as! String {
                        ud.setObject(companyId, forKey: "companyId")
                        ud.setObject(password, forKey: "password")
                        ud.synchronize()
                        self.performSegueWithIdentifier("toCompanyPage", sender: nil)
                    } else {
                        let alertController = UIAlertController(title: "エラー", message: "ユーザーIDかパスワードが違います", preferredStyle: .Alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)

                    }
                }
                }
                
            } else {
                let alertController = UIAlertController(title: "エラー", message: "ユーザーIDかパスワードが違います", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
}

