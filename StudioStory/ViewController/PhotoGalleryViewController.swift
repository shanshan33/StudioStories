//
//  PhotoGalleryViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 20/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var pickedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = pickedImage
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
