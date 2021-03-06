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
    
    // Parseにデータを挿入
    func create(userName: String!, userId: String!, pass: String!){
        let userData: PFObject = PFObject(className: "Users")
        userData.setObject(userName, forKey: "userName")
        userData.setObject(userId, forKey: "userId")
        userData.setObject(pass, forKey: "password")
        userData.saveInBackground()
    }
    
    // 端末にログイン情報保存
    func setData(userId: String!, pass: String!){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(userId, forKey: "userId")
        ud.setObject(pass, forKey: "password")
        ud.synchronize()
    }
    
    // 送信ボタン
    @IBAction func send(){
        create(name, userId: email, pass: password)
        setData(email, pass:password)
        performSegueWithIdentifier("goCompletePage", sender: nil)
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
