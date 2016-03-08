//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Thomas Clifford on 3/7/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var captionLabel: UITextField!
    @IBOutlet weak var defaultView: UIView!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet var superView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let viewTap = UITapGestureRecognizer(target: self, action:"onUpload:")
        viewTap.numberOfTapsRequired = 1
        defaultView.userInteractionEnabled = true
        defaultView.addGestureRecognizer(viewTap)
        
        let superViewTap = UITapGestureRecognizer(target: self, action:"dismissKeyboard:")
        superViewTap.numberOfTapsRequired = 1
        superView.userInteractionEnabled = true
        superView.addGestureRecognizer(superViewTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSubmit(sender: AnyObject) {
        let image = pictureView.image
        let caption = captionLabel.text
        if let image = image {
            let size = CGSize(width: image.size.width / 2, height: image.size.height / 2)
            let preparedImage = resize(image, newSize: size)
            Post.postUserImage(preparedImage, withCaption: caption, withCompletion: { (success: Bool, failure: NSError?) -> Void in
                if success {
                    print("success")
                    self.captionLabel.text = ""
                    self.defaultView.hidden = false
                    self.defaultLabel.hidden = false
                    self.tabBarController?.selectedIndex = 0
                }
            })
        }
    }
  
    
    func onUpload(sender: UITapGestureRecognizer) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            // Do something with the images (based on your use case)
            pictureView.image = editedImage
            defaultLabel.hidden = true
            defaultView.hidden = true
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func dismissKeyboard(sender: UITapGestureRecognizer) {
        self.superView.endEditing(true)
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
