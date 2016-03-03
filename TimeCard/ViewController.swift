//
//  ViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/02/23.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var idForm: UITextField!
    @IBOutlet var passForm: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.idForm.delegate = self
        self.passForm.delegate = self
        
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
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
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
                
                print(objects)
                for object in objects! {
                if object["userName"] != nil {
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
                print(objects)
                for object in objects! {
                    if object["companyName"] != nil {
                        ud.setObject(companyId, forKey: "companyId")
                        ud.setObject(password, forKey: "password")
                        ud.synchronize()
                        self.performSegueWithIdentifier("toCompanyPage", sender: nil)
                    } else {
                        let alertController = UIAlertController(title: "エラー", message: "カンパニーIDかパスワードが違います", preferredStyle: .Alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    }
                }
            } else {
                let alertController = UIAlertController(title: "エラー", message: "カンパニーIDかパスワードが違います", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        
    }
    }
    
}

