//
//  CartTableVC.swift
//  SpendingLimit
//
//  Created by Umair Ghazi on 12/9/15.
//  Copyright © 2015 Umair Ghazi. All rights reserved.
//

import UIKit

class CartTableVC: UITableViewController {

    var CartList :[String]?
    var Prod: Product!
    
    @IBAction func editCart(sender: UIBarButtonItem) {
        self.editing = !self.editing
    }
  
    @IBAction func refreshCart(sender: UIBarButtonItem) {
        self.tableView.reloadData()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        CartList = NSUserDefaults.standardUserDefaults().arrayForKey("myCart") as? [String]
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CartList != nil {
            return CartList!.count
        } else {
            return 0
        }    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
        default:
            return 100.0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CartCell", forIndexPath: indexPath)
            cell.textLabel?.text        = CartList![indexPath.row]
            cell.detailTextLabel?.text  = ""
            cell.accessoryType = .DetailButton
            return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }


    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            CartList!.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(CartList, forKey: "myCart")
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
           
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let itemToMove = CartList![fromIndexPath.row]
        CartList!.removeAtIndex(fromIndexPath.row)
        CartList!.insert(itemToMove, atIndex: toIndexPath.row)
        NSUserDefaults.standardUserDefaults().setObject(CartList, forKey: "myCart")

    }


    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
