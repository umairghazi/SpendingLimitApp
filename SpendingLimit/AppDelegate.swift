//
//  AppDelegate.swift
//  SpendingLimit
//
//  Created by Umair Ghazi on 12/13/15.
//  Copyright © 2015 Umair Ghazi. All rights reserved.
//

import UIKit
import GoogleMaps



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var tabBarController: UITabBarController?
    var setLimCont : SetLimitVC?
    
    //    private var itemId          : String = ""
    //    private var itemName        : String = ""
    //    private var itemDescription : String = ""
    //    private var imageLink       : String = ""
    //    private var originalPrice   : Double = 0.0
    //    private var discountedPrice : Double = 0.0
    
    var products : [Product] = []
    var product : Product!
    
    var sum : Double = 0.0

    var ProdTabVC = ProductTableVC()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyCcMuRrqGzTPLyBeaVdY-C0tuwoDSVSu0o")
        
        let searchQuery = "christmas"
        
        let newSearchQuery = searchQuery.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let endPoint = NSURL(string: "http://api.walmartlabs.com/v1/search?query=\(newSearchQuery)&format=json&apiKey=nq9g72p4pba3a87m223mr5ye")
        let data = NSData(contentsOfURL: endPoint!)

        if let json:NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)) as? NSDictionary {
            if let productss = json["items"] as? NSArray {
                for product in productss {
                    
                    let p = jsonProducts(json:product as! NSDictionary)
                    
                    var itemName        = ""
                    var itemDescription = ""
                    var itemImageLink   = ""
                    var itemPrice       = 0.0
                    
                    
                    if  p.itemName != nil{
                        itemName = p.itemName!
                    }else{
                        itemName = "Product Name not available"
                    }
                    
                    if  p.itemDescription != nil{
                        itemDescription = p.itemDescription!
                    }else{
                        itemDescription = "Product Description not available"
                    }
                    
                    if  p.imageLink != nil{
                        itemImageLink = p.imageLink!
                    }else{
                        itemImageLink = "Product Image not available"
                    }
                    
                    if  p.itemPrice != nil{
                        itemPrice = p.itemPrice!
                        sum = sum + itemPrice
                    }else{
                        itemPrice = 0.0
                    }
                    
                    let itemArray = Product(itemName: itemName, itemDescription: itemDescription, imageLink: itemImageLink, itemPrice: itemPrice)
                    
                    products.append(itemArray)
                }
                print(sum)
            }
            
            
        }
        
        tabBarController = self.window?.rootViewController as? UITabBarController

        let navVC = tabBarController!.viewControllers![2] as! UINavigationController
        let tableVC = navVC.viewControllers[0] as! ProductTableVC
        tableVC.products = products
        tableVC.total = sum

        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    }
    
    
}


