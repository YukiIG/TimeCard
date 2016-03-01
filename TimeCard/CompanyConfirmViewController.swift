//
//  CompanyConfirmViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/03/01.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class CompanyConfirmViewController: UIViewController {
    var name: String?
    var email: String?
    var password: String?
    var wage: String! 
    var hourlyWage: Int?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var passLabel: UILabel!
    @IBOutlet var wageLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        name = appDelegate.companyName
        email = appDelegate.companyId
        password = appDelegate.password
        wage = appDelegate.hourlyWage
        hourlyWage = Int(wage)!
        
        nameLabel.text = name
        emailLabel.text = email
        passLabel.text = password
        wageLabel.text = wage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Parseにデータを挿入
    func create(companyName: String!, companyId: String!, pass: String!, wage: Int!){
        let userData: PFObject = PFObject(className: "Companies")
        userData.setObject(companyName, forKey: "companyName")
        userData.setObject(companyId, forKey: "companyId")
        userData.setObject(pass, forKey: "password")
        userData.setObject(wage, forKey: "hourlyWage")
        userData.saveInBackground()
    }
    
    // 端末にログイン情報保存
    func setData(companyId: String!, pass: String!){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setObject(companyId, forKey: "companyId")
        ud.setObject(pass, forKey: "password")
        ud.synchronize()
    }
    
    // 送信ボタン
    @IBAction func send(){
        create(name, companyId: email, pass: password, wage: hourlyWage)
        setData(email, pass:password)
        performSegueWithIdentifier("goCompanyComplete", sender: nil)
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
