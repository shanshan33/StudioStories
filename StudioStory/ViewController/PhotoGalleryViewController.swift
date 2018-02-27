//
//  PhotoGalleryViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 20/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit
import QuartzCore

class PhotoGalleryViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoBackgroundView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var infoStackView: UIStackView!
    
    var pickedImage: UIImage?
    var frameOrigin: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = pickedImage
        // makeRoundImage(image: pickedImage!, radius: 16)
        photoImageView.layer.cornerRadius = 16
        photoImageView.clipsToBounds = true
        
        let tapToFullScreen = UITapGestureRecognizer(target: self, action: #selector(tapPhotoToFullScreen))
        tapToFullScreen.delegate = self
        photoImageView.addGestureRecognizer(tapToFullScreen)
        frameOrigin = photoImageView.frame
   
    }
    
    @objc func tapPhotoToFullScreen() {
        photoImageView.frame = UIScreen.main.bounds
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.backgroundColor = .black
        photoImageView.layer.cornerRadius = 0
        closeButton.isHidden = true
        infoStackView.isHidden = true
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        tapToDismiss.delegate = self
        photoImageView.addGestureRecognizer(tapToDismiss)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        closeButton.isHidden = false
        infoStackView.isHidden = false
        photoImageView.frame = frameOrigin!
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.backgroundColor = .clear
        photoImageView.layer.cornerRadius = 16
        
        let tapToFullScreen = UITapGestureRecognizer(target: self, action: #selector(tapPhotoToFullScreen))
        tapToFullScreen.delegate = self
        photoImageView.addGestureRecognizer(tapToFullScreen)
    }
    
    private func makeRoundImage(image: UIImage, radius: CGFloat) -> UIImage {
        let layer = CALayer()
        layer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: image.size.width, height: image.size.height))
        layer.contents = image.cgImage
        layer.masksToBounds = true
        layer.cornerRadius = radius
        
        UIGraphicsBeginImageContext(image.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let roundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundImage!
        
         }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override var previewActionItems: [UIPreviewActionItem] {
        
        let item1 = UIPreviewAction(title: "Save To Library", style: .default) {
            (action, vc) in
            UIImageWriteToSavedPhotosAlbum(self.pickedImage!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        let item2 = UIPreviewAction(title: "Item2", style: .destructive) {
            (action, vc) in
            // run item 2 action
        }
        
        return [item1, item2]
    }

}


extension PhotoGalleryViewController :  UIImagePickerControllerDelegate  {

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Saved!", message: "Image saved successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}