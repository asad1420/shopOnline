//
//  addProduct.swift
//  shopOnline
//
//  Created by MuhammadAsad on 7/31/17.
//  Copyright © 2017 MuhammadAsad. All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase

class addProduct: UIViewController {
    
    @IBOutlet weak var item_name: UITextField!
    @IBOutlet weak var item_price: UITextField!
    @IBOutlet weak var itemImage: UIImageView!
 
        
    var product = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarr()
        
        itemImage.isUserInteractionEnabled = true
        
        itemImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action:Selector(("imageHandler:"))))
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        
}
    
    @IBAction func uploadItem(_ sender: Any) {
        
        
        /*
              // Image Storage
         
         else{
         let imageName = UUID().uuidString
         
         let storageRef = FIRStorage.storage().reference().child("itemImages").child("\(imageName).jpg")
         
         if let uploadData = UIImageJPEGRepresentation(self.itemImage.image!, 0.0){
         
         
         //    if let uploadData = UIImagePNGRepresentation(self.profileImg.image!){
         
         storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) -> Void in
         
         if error != nil {
         
         print(error!)
         }
         else{
         
         if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
         
         if  user?.uid  == FIRAuth.auth()?.currentUser?.uid{
         let data = self.childRef.child("users").child((user!.uid))
         
         data.child("userName").setValue(self.nameTField.text)
         
         data.child("phone").setValue(self.phoneTField.text)
         
         data.child("email").setValue(self.email.text)
         
         data.child("pas").setValue(self.pas.text)
         
         data.child("profileImageURL").setValue(profileImageUrl)
         
         data.child("ImageName").setValue(imageName)
         
         self.for2viewController()
         
         }
         
         }
         
         }  //else ends
         
         })
         
         
         
         }
         
         
         }

         
         
         
 */
        
        
        
  
      
        
        let imageName = UUID().uuidString
        
        let storageRef = FIRStorage.storage().reference().child("itemImages").child("\(imageName).jpg")
        
        if let uploadData = UIImageJPEGRepresentation(self.itemImage.image!, 0.0){
            
            
            //    if let uploadData = UIImagePNGRepresentation(self.profileImg.image!){
            
            storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) -> Void in
                
                if error != nil {
                    
                    print(error!)
                }
                else{
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                
                    let data = self.product.child("product").childByAutoId()
                    let qrcode = data.key
                    
                    data.child("itemName").setValue(self.item_name.text)
                    data.child("itemPrice").setValue(self.item_price.text)
                    data.child("QRCode").setValue(qrcode)
                    data.child("profileImageURL").setValue(profileImageUrl)
                    data.child("ImageName").setValue(imageName)
                        
                        print("Upload Successful")
                
                    }
                
                }
                
            
            
            
            
            })}
 
        
    }

    @IBAction func back(_ sender: Any) {
        
       
        
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "admin")
            self.present(viewController, animated: true, completion: nil)
        
        
        
        
    }

    
    
    
    func navigationBarr() {
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 60))
        
        navBar.backgroundColor = UIColor.black
        
        
        self.view.addSubview(navBar);
        
        
        
        let navItem = UILabel()
        navBar.addSubview(navItem)
        
        navItem.text = "Add Items"
        navItem.textColor = UIColor.blue
        navItem.translatesAutoresizingMaskIntoConstraints = false
        navItem.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
        navItem.centerYAnchor.constraint(equalTo: navBar.centerYAnchor, constant: 4).isActive = true
        navItem.widthAnchor.constraint(equalToConstant: 130).isActive = true
        navItem.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        let button1 = UIButton(type: .custom)
        let image1 = UIImage(named:"backIcon.png")
        button1.setImage(image1, for: UIControlState())
        button1.frame = CGRect(x: 12.0, y: 17.0, width: 29.0, height: 32.0)
        button1.addTarget(self, action:#selector(addProduct.back(_:)), for: .touchUpInside)
        
        navBar.addSubview(button1)
        
    }
    
    
}
