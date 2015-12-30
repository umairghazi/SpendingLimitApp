//
//  GMapVC.swift
//  SpendingLimit
//
//  Created by Umair Ghazi on 12/14/15.
//  Copyright © 2015 Umair Ghazi. All rights reserved.
//

import Foundation
import GoogleMaps


class GMapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let camera = GMSCameraPosition.cameraWithLatitude(43.080300,
            longitude: -77.622236, zoom: 14)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(43.080300, -77.622236)
        marker.title = "Walmart"
        marker.snippet = "Marketplace Mall"
        marker.map = mapView
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

