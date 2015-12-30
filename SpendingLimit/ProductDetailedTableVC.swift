//
//  ProductDetailedTableVC.swift
//  SpendingLimit
//
//  Created by Umair Ghazi on 12/9/15.
//  Copyright © 2015 Umair Ghazi. All rights reserved.
//

import UIKit
import CoreData

class ProductDetailedTableVC: UITableViewController {

    
    var product : Product!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        if !(cell != nil){
            cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        }
        switch indexPath.section{
        case 0 :
            cell!.textLabel?.text = product.getItemName()
        case 1 :
            cell!.textLabel?.text = product.getItemDescription()
        case 2:
            let url = NSURL(string: ("\(product.getImageLink())"))
            let data = NSData(contentsOfURL : url!)
            let image = UIImage(data: data!)
            cell?.imageView?.image = image
        case 3:
        cell!.textLabel?.text = "$\(product.getItemPrice())"
        case 4:
            cell!.textLabel?.text = "Add to cart"
        default:
            break
        }
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.textAlignment = .Left

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section{
        case 4:
            var CartList = NSUserDefaults.standardUserDefaults().arrayForKey("myCart") as? [String]
            if CartList != nil {
                
                if !(CartList!.contains(product.getItemName())){
                    CartList!.append(product.getItemName())
                } else {
                    let alert = UIAlertController(title: "Already Added", message: " List already contains this item", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    break
                }
                
            } else {
                CartList = []
                CartList?.append(product.getItemName())
            }
            NSUserDefaults.standardUserDefaults().setObject(CartList, forKey: "myCart")
            let alert = UIAlertController(title: "Added to Favorites", message: "Item added to the list", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        default:
            break
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
        override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
            var title = "";
            switch section {
    
            case 0 :
                title = "Product Name"
            case 1:
                title = "Product Description"
            case 2 :
                title = "Image"
            case 3 :
                title = "Price"
            case 4 :
                title = "Add to cart"
            default:
                break
            }
            return title
        }
    
        override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
            
        case 0:
            return 50.0
        case 1:
            return 100.0
        case 2:
            return 150.0
        case 3:
            return 44.0
        
        default:
            return 44.0
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
