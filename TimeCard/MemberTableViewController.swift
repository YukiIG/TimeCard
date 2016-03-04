//
//  MemberTableViewController.swift
//  TimeCard
//
//  Created by yuki ishiguro on 2016/03/03.
//  Copyright © 2016年 yuki. All rights reserved.
//

import UIKit
import Parse

class MemberTableViewController: UITableViewController {
    var nameList: [AnyObject] = []
    var idList: [AnyObject] = []
    var sendId: String!
    let defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //セルを指定
        tableView.registerNib(
            UINib(nibName: "nameTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        let companyId: String! = defaults.stringForKey("companyId")

        
        //nameList取得
//        let query = PFQuery(className: "CompanyMember")
//        query.whereKey("companyId", equalTo: companyId)
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if error == nil {
//                print("check")
//                print(objects)
//                for object in objects!{
//                    let id = object["userId"] as! String
//                    let query2 = PFQuery(className: "Users")
//                    query2.whereKey("userId", equalTo: id)
//                    query2.findObjectsInBackgroundWithBlock { (userObjects, userError) -> Void in
//                        if userError == nil{
//                            print("check2")
//                            print(userObjects)
//                            for userObject in userObjects!{
//                                print("userName = \(userObject["userName"])")
//                                self.nameList.append(userObject["userName"])
//                                print(self.nameList)
//                            }
//                        } else {
//                            
//                        }
//                    }
//                    
//                }
//            } else {
//                print(error)
//            }
//            self.tableView.reloadData()
//        }
       
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameList = []
        idList = []
        let query = PFQuery(className: "CompanyMember")
        query.cachePolicy = PFCachePolicy.NetworkElseCache
        query.whereKey("companyId", equalTo: defaults.stringForKey("companyId")!)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("check")
                print(objects)
                for object in objects!{
                    let id = object["userId"] as! String
                    let query2 = PFQuery(className: "Users")
                    query2.cachePolicy = PFCachePolicy.NetworkElseCache
                    query2.whereKey("userId", equalTo: id)
                    query2.findObjectsInBackgroundWithBlock { (userObjects, userError) -> Void in
                        if userError == nil{
                            print("check2")
                            print(userObjects)
                            for userObject in userObjects!{
                                print("userName = \(userObject["userName"])")
                                self.nameList.append(userObject["userName"])
                                self.idList.append(userObject["userId"])
                                print(self.nameList)
                            }
                            print("check3")
                            self.tableView.reloadData()

                        } else {
                            
                        }
                    }
                    
                }
            } else {
                print(error)
            }
           
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nameList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! nameTableViewCell
        
        cell.nameLabel.text = nameList[indexPath.row] as! String
        return cell
    }
    
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        sendId = idList[indexPath.row] as! String
        performSegueWithIdentifier("goDetail", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "goDetail") {
            let detailController: DetailViewController = (segue.destinationViewController as? DetailViewController)!
            
            detailController.userId = sendId
            
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
