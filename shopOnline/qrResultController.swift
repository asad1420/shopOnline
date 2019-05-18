//
//  qrResultController.swift
//  shopOnline
//
//  Created by MuhammadAsad on 8/2/17.
//  Copyright © 2017 MuhammadAsad. All rights reserved.
//

import UIKit
import Firebase

class qrResultController: UIViewController,UITabBarDelegate, UITableViewDataSource {

   
    
    
    @IBOutlet weak var tableR: UITableView!
   
    
    var arrTable = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
     //   print(global.globeVar.arrGlobal.count)
     //   print("above")
    //    return global.globeVar.arrGlobal.count
    
    
    return arrTable.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
   //     cell.textLabel?.text = global.globeVar.arrGlobal[indexPath.row]
        cell.textLabel?.text = arrTable[indexPath.row]
     
        
        return cell
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       navigationBarr()
        
        if global.globeVar.flagSign == true {
        
            scanedData()
            global.globeVar.flagSign = false
            
            
        
        }
        
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
}
    
    func scanedData(){
        
        if let scannedQR = global.globeVar.qrCode {
            
            
            let ref =  FIRDatabase.database().reference().child("product").child(scannedQR)
            ref.observeSingleEvent(of: .value, with: { (snap) -> Void in
                
                
                let snapshotValue = snap.value
                
                
                let itemName: String!
                
                itemName = (snapshotValue as AnyObject).value(forKey: "itemName") as? String
               print(itemName)
             self.dataString(string: itemName)
                
                global.globeVar.dataSign = global.globeVar.dataSign + 1
            
                DispatchQueue.main.async(execute: { () -> Void in
                    
                 
                    self.tableR.reloadData()
                })
                
                
             //   global.globeVar.arrGlobal.append(itemName)
                
            
            })
            
            
            
        }
        
        
        
        
        
        
    }
    
    func dataString(string: String) {
     
        if global.globeVar.dataSign < 1 {
        
       
            print(global.globeVar.dataSign)
            
            global.globeVar.arrGlobal.append(string)
            
       arrTable =   global.globeVar.arrGlobal.removeDuplicates()
         
            global.globeVar.dataSign = global.globeVar.dataSign + 1
            
             print(global.globeVar.dataSign)
            
        
            
        }
        else {
        
            print("Error1420")
        
        }
    
    }
    
   
    
    
    func guestHome(_ sender: AnyObject){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "guest")
        self.present(viewController, animated: true, completion: nil)
        
        
        
    }

    
    func navigationBarr() {
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 60))
        
        navBar.backgroundColor = UIColor.black
        
        
        self.view.addSubview(navBar);
        
        
        
        let navItem = UILabel()
        navBar.addSubview(navItem)
        
        navItem.text = "KK SuperMart"
        navItem.textColor = UIColor.blue
        navItem.translatesAutoresizingMaskIntoConstraints = false
        navItem.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
        navItem.centerYAnchor.constraint(equalTo: navBar.centerYAnchor, constant: 4).isActive = true
        navItem.widthAnchor.constraint(equalToConstant: 130).isActive = true
        navItem.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
    
        
        let button1 = UIButton(type: .infoDark)
        button1.setTitle("backIcon", for: .normal)
        button1.frame = CGRect(x: 12.0, y: 17.0, width: 29.0, height: 32.0)
        button1.addTarget(self, action:#selector(qrResultController.guestHome(_:)), for: .touchUpInside)
        
        navBar.addSubview(button1)
        
      
    }

    
    
    
    
    
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}
