//
//  QRCodeVC.swift
//  SpendingLimit
//
//  Created by Umair Ghazi on 12/8/15.
//  Copyright © 2015 Umair Ghazi. All rights reserved.
//  QR Code reader example used from -- http://www.theappguruz.com/blog/qrcode-reader-using-swift

import UIKit
import AVFoundation

class QRCodeVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate, UISearchBarDelegate {

    
    var objCaptureSession: AVCaptureSession?
    var objCaptureVideoPreviewLayer: AVCaptureVideoPreviewLayer?
    var vwQRCode : UIView?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBAction func searchButtonAction(sender:UIButton) {
        fetchData()
    }
    
    
    func fetchData(){
        let searchQuery : String = self.searchBar.text!
        let newSearchQuery = searchQuery.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let endPoint = NSURL(string: "http://api.walmartlabs.com/v1/search?query=\(newSearchQuery)&format=json&apiKey={{YourAPIKey}}")
        
        let data = NSData(contentsOfURL: endPoint!)
        
        if let json:NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)) as? NSDictionary {
            
            if let productss = json["items"] as? NSArray {
                
                for product in productss {
                    let p = jsonProducts(json:product as! NSDictionary)
                    let itemName = p.itemName!
                    
                    var itemDescription = ""
                    if  p.itemDescription != nil{
                        itemDescription = p.itemDescription!
                    }else{
                        itemDescription = "no data"
                    }
                    let itemPrice = Double(p.itemPrice!)
                    let imageLink = p.imageLink!
                    let fetchedArr = Product(itemName: itemName, itemDescription: itemDescription,imageLink: imageLink, itemPrice: itemPrice)
                    
                    print("\(fetchedArr.getItemName()) \n\n \(fetchedArr.getItemDescription()) \n\n \(fetchedArr.getImageLink()) \n\n \(fetchedArr.getItemPrice()) \n ")
                }
                
            }
        }
        
    }

    
    func configureVideoCapture(){
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error : NSError?
        let objCaptureDeviceInput: AnyObject!
        do{
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice) as AVCaptureDeviceInput
        } catch let error1 as NSError{
            error = error1
            objCaptureDeviceInput = nil
        }
        if (error != nil){
            let alertView:UIAlertView = UIAlertView(title: "Device error", message: "Device not supported for this app", delegate: nil, cancelButtonTitle: "Ok Done")
            alertView.show()
            return
        }
        objCaptureSession = AVCaptureSession()
        objCaptureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        objCaptureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
    }
    
    
    func addVideoPreviewLayer(){
        
        objCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: objCaptureSession)
        objCaptureVideoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        objCaptureVideoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(objCaptureVideoPreviewLayer!)
        objCaptureSession?.startRunning()
        self.view.bringSubviewToFront(searchBar)
        self.view.bringSubviewToFront(searchButton)
    }
    
    func initializeQRView() {
        vwQRCode = UIView()
        vwQRCode?.layer.borderColor = UIColor.redColor().CGColor
        vwQRCode?.layer.borderWidth = 5
        self.view.addSubview(vwQRCode!)
        self.view.bringSubviewToFront(vwQRCode!)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            vwQRCode?.frame = CGRectZero
//            warningLabel.text = "NO QRCode text detected"
            return
        }else{
//            self.warningLabel.hidden = true
        }
        
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = objCaptureVideoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            vwQRCode?.frame = objBarCode.bounds;
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                searchBar.text = objMetadataMachineReadableCodeObject.stringValue
            }
        }
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureVideoCapture()
        self.addVideoPreviewLayer()
        self.initializeQRView()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
        // Do any additional setup after loading the view.

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
