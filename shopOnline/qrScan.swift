//
//  qrScan.swift
//  shopOnline
//
//  Created by MuhammadAsad on 8/1/17.
//  Copyright © 2017 MuhammadAsad. All rights reserved.
//

import UIKit
import AVFoundation

class qrCodeScan: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var back: UIButton!
    var video = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let session = AVCaptureSession()
        
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do{
            
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
            
        }
        catch{
            
            print("ERROR!!")
        }
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        self.view.bringSubview(toFront: back )
        
        session.startRunning()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "mainC")
        self.present(viewController, animated: true, completion: nil)
        
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects != nil && metadataObjects.count != 0 {
            
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                
                if object.type == AVMetadataObjectTypeQRCode {
                    
                    global.globeVar.qrCode = object.stringValue
                    global.globeVar.flagSign = true
                    global.globeVar.dataSign = 0
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "qrResult")
                    self.present(viewController, animated: true, completion: nil)
                    
                    
                    
                    
                    
                    
                    /*   let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                    }))
                    
                    present(alert, animated: true, completion: nil)
                    */
                
                }
                
            }
            
            
        }
    }
    
}
