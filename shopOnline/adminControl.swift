//
//  adminControl.swift
//  shopOnline
//
//  Created by MuhammadAsad on 7/31/17.
//  Copyright © 2017 MuhammadAsad. All rights reserved.
//

import UIKit
import Firebase

class adminControl: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarr()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        
    }
    
    func signOuut(_ sender: AnyObject){
        
        
            print("SignOut Successfully")
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "login")
            self.present(viewController, animated: true, completion: nil)
            
            
        
    }
    func addcontent(_ sender: AnyObject){
    
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "addProduct")
        self.present(viewController, animated: true, completion: nil)
    
    
    
    }

    
    func navigationBarr() {
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 60))
        
        navBar.backgroundColor = UIColor.black
    
        
        self.view.addSubview(navBar);
        
        
        
        let navItem = UILabel()
        navBar.addSubview(navItem)
        
        navItem.text = "AdminPanel"
        navItem.textColor = UIColor.blue
        navItem.translatesAutoresizingMaskIntoConstraints = false
        navItem.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
        navItem.centerYAnchor.constraint(equalTo: navBar.centerYAnchor, constant: 4).isActive = true
        navItem.widthAnchor.constraint(equalToConstant: 130).isActive = true
        navItem.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        let button = UIButton(type: .custom)
        let image = UIImage(named:"exit.png")
        button.setImage(image, for: UIControlState())
        button.frame = CGRect(x: 330.0, y: 17.0, width: 33.0, height: 33.0)
        button.addTarget(self, action:#selector(adminControl.signOuut(_:)), for: .touchUpInside)
        
        navBar.addSubview(button)
    
        let button1 = UIButton(type: .custom)
        let image1 = UIImage(named:"add.png")
        button1.setImage(image1, for: UIControlState())
        button1.frame = CGRect(x: 12.0, y: 17.0, width: 29.0, height: 32.0)
        button1.addTarget(self, action:#selector(adminControl.addcontent(_:)), for: .touchUpInside)
    
        navBar.addSubview(button1)
        
    }
    

}
