//
//  imageHandler.swift
//  shopOnline
//
//  Created by MuhammadAsad on 8/3/17.
//  Copyright © 2017 MuhammadAsad. All rights reserved.
//
import Foundation
import UIKit

extension addProduct: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imageHandler(_ sender: UITapGestureRecognizer) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedPicker: UIImage?
        
        //   print(info)
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
            selectedPicker = originalImage
        }
            
        else {
            let editedimage = info["UIImagePickerControllerEditedImage"] as? UIImage
            selectedPicker = editedimage
            
        }
     
        itemImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        itemImage.image = selectedPicker
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel")
        dismiss(animated: true, completion: nil)
    }
    
}
