//
//  ViewController.swift
//  shopOnline
//
//  Created by MuhammadAsad on 7/31/17.
//  Copyright © 2017 MuhammadAsad. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        
    }

    @IBAction func submit(_ sender: Any) {
        
        if userName.text == "admin" && password.text == "admin" {
        
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "admin")
            self.present(viewController, animated: true, completion: nil)
        
        }
        
        
    }

    @IBAction func guestControl(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "guest")
        self.present(viewController, animated: true, completion: nil)
        
    }
    
}

