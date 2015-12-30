//
//  Product.swift
//  SpendingLimit
//
//  Created by Umair Ghazi on 12/9/15.
//  Copyright © 2015 Umair Ghazi. All rights reserved.
//

import Foundation


class Product: NSObject, CustomDebugStringConvertible{
    
    private var itemName        : String = ""
    private var itemDescription : String = ""
    private var imageLink       : String = ""
    private var itemPrice       : Double = 0.0
    
    
        override var description : String{
            return "{\n\t itemName: \(itemName), \n\t itemDescription: \(itemDescription), \n\t imageLink: \(imageLink), \n\t itemPrice: \(itemPrice) }"
        }
        override var debugDescription : String{
            return "{\n\t itemName: \(itemName), \n\t itemDescription: \(itemDescription), \n\t imageLink: \(imageLink), \n\t itemPrice: \(itemPrice) }"
        }
    
    init(itemName: String, itemDescription: String, imageLink: String, itemPrice:Double) {
        self.itemName = itemName
        self.itemDescription = itemDescription
        self.imageLink = imageLink
        self.itemPrice = itemPrice
    }
    
    @objc var title : String? {
        get {
            return itemName
        }
    }
    
    @objc var subtitle : String? {
        get {
            return itemDescription
        }
    }
    
    func getItemName() -> String {
        return itemName
    }
    

    
    func getItemDescription() -> String {
        return itemDescription
    }
    
    func getImageLink() -> String {
        return imageLink
    }
    
    
    func getItemPrice() -> Double {
        return itemPrice
    }
}