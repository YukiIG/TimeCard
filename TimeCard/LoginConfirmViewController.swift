//
//  LoginConfirmViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/03/01.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class LoginConfirmViewController: UIViewController {
    var name: String?
    var email: String?
    var password: String?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        name = appDelegate.userName
        email = appDelegate.userId
        password = appDelegate.password
       
        nameLabel.text = name
        emailLabel.text = email
        passLabel.text = password
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
