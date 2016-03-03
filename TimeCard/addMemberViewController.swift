//
//  addMemberViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/03/03.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class addMemberViewController: UIViewController {
    @IBOutlet var userForm: UITextField!
    @IBOutlet var passForm: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Parse データ追加
    func create(companyId: String!, userId: String!){
        let userData: PFObject = PFObject(className: "CompanyMember")
        userData.setObject(companyId, forKey: "companyId")
        userData.setObject(userId, forKey: "userId")
        userData.saveInBackground()
    }
    
    //戻る
    @IBAction func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //メンバー追加
    @IBAction func add(){
        let userId: String! = userForm.text
        let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let companyId: String! = defaults.stringForKey("companyId")
        create(companyId, userId: userId)
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
