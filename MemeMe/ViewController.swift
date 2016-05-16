//
//  ViewController.swift
//  MemeMe
//
//  Created by Kenan Ozdamar on 5/13/16.
//  Copyright © 2016 OKO Baycity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //UIImagePickerControllerDelegate protocol defines functionality for how image selected from ImagePicker should be processed.
    //UINavigationControllerDelegate needed to set this class as the protocol fot the delegate.
    
    //outlet to the image being displaued in main view conttoller
    @IBOutlet weak var image_view: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pickImageFromUIImagePicker(sender: AnyObject) {
        //when user select "album" button this method is triggered which displays an ios include view controller
        //that allows user to pick image from album.

        print("pickImageFromUIImagePicker has been executed.")
        
        //load an instance of the ios provided view controller to pick image from library
        let imagePickerController = UIImagePickerController()
        
        //set the delegate from the UIImagePicker. this class is defining the protocol.
        imagePickerController.delegate = self
        
        //present the view controller.
        self.presentViewController(imagePickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        //override this method from UIImagePickerControllerDelegate protocol to specify how selected image should be diplayed.
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            image_view.image = image
            print("setting image")
        }else {
            print("something has gone wrong picking the image.")
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        
    }
}

