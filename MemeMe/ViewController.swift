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
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ]
    
    //outlet to the image being displaued in main view conttoller
    @IBOutlet weak var image_view: UIImageView!
    
    @IBOutlet weak var top_textfield: UITextField!
    @IBOutlet weak var bottom_texfield: UITextField!
    
    let custom_textfield_delegate = CustomTextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        top_textfield.defaultTextAttributes = memeTextAttributes
        bottom_texfield.defaultTextAttributes = memeTextAttributes
        
        top_textfield.textAlignment = .Center
        top_textfield.delegate = custom_textfield_delegate
        
        bottom_texfield.textAlignment = .Center
        bottom_texfield.delegate = custom_textfield_delegate

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Sign up to be notified when the keyboard appears
        subscribeToKeyboardNotifications()
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
     
        //unsubscribe from the notifications.
        unsubscribeFromKeyboardNotifications()
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
    
    func subscribeToKeyboardNotifications() {
        //subscribes to observer which receives keyboard will show notifications.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        //unsubscribes from the keyboard will show observer.
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification){
//        view.frame.origin.y += getKeyboardHeight(notification)
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
}

