//
//  SetLimitVC.swift
//  SpendingLimit
//
//  Created by Umair Ghazi on 12/8/15.
//  Copyright © 2015 Umair Ghazi. All rights reserved.
//

import UIKit

class SetLimitVC: UIViewController, UITextFieldDelegate {

    
    var ProdTabVC = ProductTableVC()
    
    var limit : Double!
    
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var didEnterAmount: UITextField!
    @IBAction func dismissKeypad(sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func saveAmount(sender: UIButton) {
        if amount.text! == "" {
            let alert = UIAlertController(title: "Amount Not Entered", message: "You did not enter an amount", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
        let x = amount.text!
        limit = Double(x)!
        print(x)
        NSUserDefaults.standardUserDefaults().setDouble(limit, forKey: "limitVal")

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
