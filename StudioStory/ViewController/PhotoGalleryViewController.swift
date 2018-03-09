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
    @IBOutlet weak var photoImageView: GalleryImageView!
    @IBOutlet weak var photoBackgroundView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var infoStackView: UIStackView!
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var photoCreateDateLabel: UILabel!

    @IBOutlet var photoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var photoImageViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorsStackView: UIStackView!
    @IBOutlet weak var RGBstackView: UIStackView!
    
    @IBOutlet weak var backgroudStackView: UIStackView!
    
    @IBOutlet weak var Footer: UIView!

    var frameOrigin: CGRect?
    var photoViewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //       photoImageView.layer.cornerRadius = 16
   //     photoImageView.clipsToBounds = true
        
 //       let tapToFullScreen = UITapGestureRecognizer(target: self, action: #selector(tapPhotoToFullScreen))
 //       tapToFullScreen.delegate = self
 //       photoInfoScrollView.addGestureRecognizer(tapToFullScreen)
 //       frameOrigin = photoImageView.frame
        
        setupPhotoGallery(photoViewModel: photoViewModel)
        photoInfoScrollView.delegate = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoImageView.invalidateIntrinsicContentSize()

        photoInfoScrollView.contentOffset = CGPoint(x: 0, y: -452)
        photoInfoScrollView.contentInset = UIEdgeInsets(top: 452, left: 0, bottom: 0, right: 0)

    }
    
    
    private func configGalleryShadow() {
        
  //      photoImageView.layer.cornerRadius = 16
  //      photoImageView.layer.borderColor = UIColor.white.cgColor
 //       photoImageView.layer.borderWidth = 2.0

        //     photoImageView.clipsToBounds = false
        photoImageView.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.15).cgColor
        photoImageView.layer.shadowOpacity = 1.0
        photoImageView.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        photoImageView.layer.shadowRadius = 21.0
        photoImageView.layer.shadowPath = UIBezierPath(rect: photoImageView.bounds).cgPath
        photoImageView.layer.masksToBounds = false
    }
    
    func setupPhotoGallery(photoViewModel: PhotoViewModel) {
        guard let photo = photoViewModel.image else { return }
        self.photoImageView.image = photo.radiusImage(32, size: photo.size)
        photoImageView.clipsToBounds = true
        self.groupNameLabel.text = photoViewModel.groupName
        self.photoCreateDateLabel.text =  photoViewModel.createDate
        
        var hexArray: [String] = []
        photo.getColors { colors in
            for (index, colorView) in self.colorsStackView.subviews.enumerated() {
                colorView.backgroundColor = colors[index]
                colorView.roundCorners([.topLeft, .topRight], radius: 4)
            }
            for color in colors {
                hexArray.append(color.toHex()!)
            }
            for (index, label) in self.RGBstackView.subviews.enumerated() {
                if let label = label as? UILabel{
                    label.text = "#\(hexArray[index])"
                }
            }
            
            for background in self.backgroudStackView.subviews {
           //     self.addShadowTo(colorView: background)
                background.layer.cornerRadius = 4

            }
            print("colors: \(colors)")
        }

    }
    
    private func addShadowTo(colorView: UIView) {
 
        colorView.layer.cornerRadius = 4
//        colorView.backgroundColor = UIColor(red:0.82, green:0.01, blue:0.11, alpha:1)
        colorView.layer.borderWidth = 2
        colorView.layer.borderColor = UIColor.white.cgColor
        colorView.layer.shadowOffset = CGSize(width: 0, height: 4)
        colorView.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.08).cgColor
        colorView.layer.shadowOpacity = 1
        colorView.layer.shadowRadius = 10
        colorView.layer.masksToBounds = false
//        colorView.layer.shadowPath = UIBezierPath(roundedRect:colorView.bounds, cornerRadius:colorView.layer.cornerRadius).cgPath
        
    }
    
    func setupPhotoGallery(_ photoStory: PhotoStory) {
        guard let photo = photoStory.image else { return }
        self.photoImageView.image = photo.radiusImage(16, size: photoImageView.frame.size)
        photoImageView.clipsToBounds = true
        self.groupNameLabel.text = photoStory.groupName
        self.photoCreateDateLabel.text = "Uploaded \(dateToString(dateToString: photoStory.createDate!))"
        
        var hexArray: [String] = []
        photo.getColors { colors in
            for (index, colorView) in self.colorsStackView.subviews.enumerated() {
                colorView.backgroundColor = colors[index]
            }
            
            for color in colors {
                hexArray.append(color.toHex()!)
            }
            
            for (index, label) in self.RGBstackView.subviews.enumerated() {
                if let label = label as? UILabel{
                    label.text = "#\(hexArray[index])"
                }
            }
            print("colors: \(colors)")
        }
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
 //       photoImageView.image = story?.image
  //      photoImageView.contentMode = .scaleAspectFit
        photoImageView.backgroundColor = .black
        photoImageView.layer.cornerRadius = 0
        colorView.isHidden = true
        closeButton.isHidden = true
        Footer.isHidden = true
        let tapToDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        tapToDismiss.delegate = self
        photoInfoScrollView.addGestureRecognizer(tapToDismiss)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        closeButton.isHidden = false
        Footer.isHidden = false
        photoImageView.frame = frameOrigin!
 //       photoImageView.contentMode = .scaleAspectFit
        photoImageView.backgroundColor = .clear
        photoImageView.layer.cornerRadius = 16
        
        let tapToFullScreen = UITapGestureRecognizer(target: self, action: #selector(tapPhotoToFullScreen))
        tapToFullScreen.delegate = self
        photoInfoScrollView.addGestureRecognizer(tapToFullScreen)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showColorPalette(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.photoInfoScrollView.contentOffset = CGPoint(x: 0, y: -352)
            self.photoImageView.frame.size.height = 352

        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override var previewActionItems: [UIPreviewActionItem] {
        
        let item1 = UIPreviewAction(title: "Save To Library", style: .default) {
            (action, vc) in
            guard let image = self.photoViewModel.image else { return }
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
//
//        let item2 = UIPreviewAction(title: "Item2", style: .destructive) {
//            (action, vc) in
//            // run item 2 action
//        }
        return [item1]
    }
}

extension PhotoGalleryViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        photoInfoScrollView.contentSize = CGSize(width: photoInfoScrollView.frame.size.width, height: 130)
        let offsetY = scrollView.contentOffset.y
        
        if offsetY < 0
        {
            print("scroll down, offset \(offsetY)")

            photoImageView.frame.size.height = -offsetY
        } else {
            print("scroll up, offset \(offsetY)")
            photoImageView.frame.size.height = photoImageView.frame.height
        }
 //       photoImageView.invalidateIntrinsicContentSize()

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
