//
//  CompanyLoginViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/03/01.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit

class CompanyLoginViewController: UIViewController {
    @IBOutlet var nameForm: UITextField!
    @IBOutlet var emailForm: UITextField!
    @IBOutlet var passForm: UITextField!
    @IBOutlet var wageForm: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 確認ボタン
    @IBAction func sendData(){
        
        if nameForm.text != "" && emailForm.text != "" && passForm.text != "" && wageForm.text != "" {
            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.companyName = nameForm.text
            appDelegate.companyId = emailForm.text
            appDelegate.password = passForm.text
            appDelegate.hourlyWage = wageForm.text
            performSegueWithIdentifier("goCompanyConfirm", sender: nil)
        } else {
            let alertController = UIAlertController(title: "エラー", message: "必要事項を入力してください", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
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
