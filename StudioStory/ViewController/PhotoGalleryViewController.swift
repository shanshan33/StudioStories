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

    @IBOutlet weak var photoInfoScrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoBackgroundView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var infoStackView: UIStackView!
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var photoCreateDateLabel: UILabel!

    @IBOutlet var photoImageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var photoImageViewWidthConstraint: NSLayoutConstraint!
    
    var frameOrigin: CGRect?
    var story: PhotoStory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPhotoGallery(story!)
        photoImageView.layer.cornerRadius = 16
   //     photoImageView.clipsToBounds = true
        
        let tapToFullScreen = UITapGestureRecognizer(target: self, action: #selector(tapPhotoToFullScreen))
        tapToFullScreen.delegate = self
        photoInfoScrollView.addGestureRecognizer(tapToFullScreen)
        frameOrigin = photoImageView.frame
        
        photoInfoScrollView.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        photoInfoScrollView.contentOffset = CGPoint(x: 0, y: -425)
        photoInfoScrollView.contentInset = UIEdgeInsets(top: 425, left: 0, bottom: 0, right: 0)
    }
    
    func setupPhotoGallery(_ photoStory: PhotoStory) {
        self.photoImageView.image = self.makeRoundedImage(image:photoStory.image!, radius: 16)
        photoImageView.clipsToBounds = true
        self.groupNameLabel.text = photoStory.groupName
        self.photoCreateDateLabel.text = "Uploaded \(dateToString(dateToString: photoStory.createDate!))"
    }
    
    private func dateToString(dateToString: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d, YYYY"
        let dateString = dateFormatter.string(from: dateToString)
        return dateString
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
    
    func makeRoundedImage(image: UIImage, radius: Float) -> UIImage {
        let imageLayer = CALayer()
        imageLayer.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        imageLayer.contents = image.cgImage
        
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = CGFloat(radius)
        
        UIGraphicsBeginImageContext(image.size)
        imageLayer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showColorPalette(_ sender: UIButton) {
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override var previewActionItems: [UIPreviewActionItem] {
        
        let item1 = UIPreviewAction(title: "Save To Library", style: .default) {
            (action, vc) in
            guard let image = self.story?.image else { return }
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        let item2 = UIPreviewAction(title: "Item2", style: .destructive) {
            (action, vc) in
            // run item 2 action
        }
        
        return [item1, item2]
    }
}

extension PhotoGalleryViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        photoInfoScrollView.contentSize = CGSize(width: photoInfoScrollView.frame.size.width, height: 100)
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0 && offsetY < -303 {
            print("scroll down, offset \(offsetY)")

            photoImageView.frame.size.height = -offsetY
        } else {
            print("scroll up, offset \(offsetY)")

   //         photoInfoScrollView.backgroundColor = .blue
            photoImageView.frame.size.height = photoImageView.frame.height
        }
        
        
//        if offsetY < 0
//        {
//            print("scroll down")
//            UIView.animate(withDuration: 1, animations: {
//                DispatchQueue.main.async {
//                    self.photoImageViewHeightConstraint.isActive = true
//                    self.photoImageViewWidthConstraint.isActive = true
//                    self.photoInfoScrollView.layoutIfNeeded()
//                }
//            })
//        }
//        else
//        {
//            print("scroll up")
//            UIView.animate(withDuration: 1, animations: {
//                DispatchQueue.main.async {
//                    self.photoImageViewHeightConstraint.constant = 300
//                    self.photoImageViewWidthConstraint.constant = 250
//                    self.photoInfoScrollView.layoutIfNeeded()
//                }
//
//            })
//        }
    }
}


extension PhotoGalleryViewController:  UIImagePickerControllerDelegate  {

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
