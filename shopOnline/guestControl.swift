//
//  guestControl.swift
//  shopOnline
//
//  Created by MuhammadAsad on 8/1/17.
//  Copyright © 2017 MuhammadAsad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import AVFoundation

class guestControl: UIViewController,UITabBarDelegate,UITableViewDelegate, UITableViewDataSource {
    
 //   @IBOutlet weak var itemName: UILabel!
 //   @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var tableGuest: UITableView!
   
    var imageCache = [String: UIImage]()
    var items = [itemsDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         tableGuest.register(userCell.self, forCellReuseIdentifier: "cell")
        
        navigationBarr()
        dataFetch()
        
        if global.globeVar.flagSign == true {
        
        //    scanedData()
            global.globeVar.flagSign = false
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      //   let cell = UITableViewCell(style: .default, reuseIdentifier: "cell") as! userCell
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! userCell
        
        
        let value = items[indexPath.row]
        
        cell.textLabel?.text = value.itemName
        
        cell.profileImageView.image = nil
        
        if let profileImageUrl = value.profileImageURL {
            
            let url = NSURL(string: profileImageUrl)
            
            if let imagea = self.imageCache[profileImageUrl]{
                
                cell.profileImageView.image = imagea
                
            }
                
            else{
                
                GetDatafromURL(url: url! as URL, completion: { (data, response, error) in
                    
                    if error != nil{
                        
                        print(error!)
                    }
                    else{
                        
                        /*  if let imagea = self.imageCache[profileImageUrl]{
                         
                         cell.profileImageView.image = imagea
                         return
                         }
                         */
                        
                        if let image = UIImage(data: data!){
                            
                            self.imageCache[profileImageUrl] = image
                            
                        }
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            //         cell.imageView?.image = UIImage(data: data!)
                            
                            
                            cell.profileImageView.image = UIImage(data: data!)
                            
                            
                        })
                        
                        
                    }
                    
                })
               
            
        }
    
        
        
        
        }
        
        return cell
    
    }
    
    func scanQR(_ sender: AnyObject){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "qrScan")
        self.present(viewController, animated: true, completion: nil)
        
        
        
    }
    
    func home(_ sender: AnyObject){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "login")
        self.present(viewController, animated: true, completion: nil)
        
        
        
    }
 
    /*
    func scanedData(){
        
        if let scannedQR = global.globeVar.qrCode {
        
            
          let ref =  FIRDatabase.database().reference().child("product").child(scannedQR)
            ref.observeSingleEvent(of: .value, with: { (snap) -> Void in
                
                let snapshotValue = snap.value
                self.itemName.text = (snapshotValue as AnyObject).value(forKey: "itemName") as? String
                self.itemPrice.text = (snapshotValue as AnyObject).value(forKey: "itemPrice") as? String
            })
            
            
            /*   let ref = FIRDatabase.database().reference().child("product").child(scannedQR)
            
            ref.observe(.childAdded, with: { snapshot in
                
                
                
            })
           */
        
        }
        
        
    
      
        
 
    }
    */
    
    
    func dataFetch(){
        
        
        FIRDatabase.database().reference().child("product").observe(.childAdded, with: { (snap) -> Void in
            
            let dic = snap.value as? [String: AnyObject]
            let item = itemsDetail()
            //  print(dic!)
            
            
            
            
            item.setValuesForKeys(dic!)
            self.items.append(item)
            
      //      print(self.users)
            
            
            DispatchQueue.main.async(execute: { () -> Void in
                
                self.tableGuest.reloadData()
            })
            
            
            
            
            
        }, withCancel: nil)
        
        
        
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
        
        let button = UIButton(type: .custom)
        let image = UIImage(named:"qrScanImage.png")
        button.setImage(image, for: UIControlState())
        button.frame = CGRect(x: 330.0, y: 17.0, width: 33.0, height: 33.0)
        button.addTarget(self, action:#selector(guestControl.scanQR(_:)), for: .touchUpInside)
        
        let button1 = UIButton(type: .infoDark)
        button1.setTitle("Home", for: .normal)
        button1.frame = CGRect(x: 12.0, y: 17.0, width: 29.0, height: 32.0)
        button1.addTarget(self, action:#selector(guestControl.home(_:)), for: .touchUpInside)
        
        navBar.addSubview(button1)
        
        navBar.addSubview(button)
}

        func GetDatafromURL(url: URL, completion: @escaping ((_ data: Data?, _ response: URLResponse?,  _ error: Error?) -> Void))
        {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                completion (data , response, error)
                
                }.resume()
        }
        
        
        
        
        
    //       UserCell -- Custom Cell
    
        
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    class userCell: UITableViewCell {
        override func layoutSubviews() {
            super.layoutSubviews()
            
            textLabel?.frame = CGRect(64, ((textLabel?.frame.origin.y )! - 4), ((textLabel?.frame.width)! + 50), (textLabel?.frame.height)!)
            
            detailTextLabel?.frame = CGRect(64, ((textLabel?.frame.origin.y)! + 20), ((textLabel?.frame.width)! + 50), (textLabel?.frame.height)!)
        }
        
        
        
        let profileImageView: UIImageView = {
            
            let imageview = UIImageView()
            imageview.image = UIImage(named: "no-photo-available-38c6756507deebf97b071bf8ff7bcf29.jpg")
            imageview.translatesAutoresizingMaskIntoConstraints = false
            imageview.layer.cornerRadius = 24
            imageview.layer.masksToBounds = true
            return imageview
        }()
        
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            
            addSubview(profileImageView)
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
            profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
}
extension CGRect {
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
    
}
