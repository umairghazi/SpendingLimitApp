//
//  JSON.swift
//  SpendingLimit
//
//  Created by Umair Ghazi on 12/10/15.
//  Copyright © 2015 Umair Ghazi. All rights reserved.
//

import Foundation



class jsonProducts {
    var itemName: String?
    var itemDescription: String?
    var imageLink : String?
    var itemPrice : Double?
    
    init(){
        
    }
    
    init(json:NSDictionary){
        
        if let iName = json["name"] as? String {
            itemName = iName
        }
        
        if  json["shortDescription"] != nil{
            self.itemDescription = json["shortDescription"] as? String
        }else{
            self.itemDescription = json["longDescription"] as? String
        }
        if let iImageLink = json["thumbnailImage"] as? String {
            self.imageLink = iImageLink
        }
        if  json["msrp"] != nil{
            self.itemPrice = json["msrp"] as? Double
        }else{
            self.itemPrice = json["salePrice"] as? Double
        }
        
    }
}