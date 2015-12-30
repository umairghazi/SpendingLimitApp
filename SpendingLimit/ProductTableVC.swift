//
//  ProductTableVC.swift
//  SpendingLimit
//
//  Created by Umair Ghazi on 12/9/15.
//  Copyright © 2015 Umair Ghazi. All rights reserved.
//

import UIKit

class ProductTableVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var productList = Products()
    var products : [Product]{
        get{
            return self.productList.productList!
        }
        set(val) {
            self.productList.productList = val
        }
    }
    
    @IBOutlet weak var tableViewCell: UITableViewCell!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var limit = 0.0
    var total = 0.0
    
    @IBOutlet weak var limitLabel: UILabel!
    

    
     override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(animated: Bool) {
        limit = NSUserDefaults.standardUserDefaults().doubleForKey("limitVal")
        totalLabel.text! = "Total: \(total)"
        limitLabel.text! = "Limit: \(limit)"
        
        if total > limit{
            let diff = total - limit
            totalLabel.textColor = UIColor(red: 0.9, green: 0.0, blue: 0.0, alpha: 1.0)
            let alert = UIAlertController(title: "Budget Exceeded", message: "You exceed your limit by $\(diff)", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            totalLabel.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        }
        self.tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath)

        let product = products[indexPath.row]
        cell.textLabel?.text = product.getItemName()
        cell.detailTextLabel?.text = "$\(product.getItemPrice())"
        cell.accessoryType = .DisclosureIndicator
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //dont use both this and segue
        let product = products[indexPath.row]
        let detailVC = ProductDetailedTableVC(style:.Grouped)
        detailVC.title =  product.getItemName()
        detailVC.product = product
        navigationController?.pushViewController(detailVC, animated: true)
    }
}