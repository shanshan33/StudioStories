//
//  GalleryImageView.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 09/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class GalleryImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var intrinsicContentSize: CGSize {
        
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth / myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        
        return CGSize(width: -1.0, height: -1.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configShadow()

    }
    
    private func configShadow() {
        
        //      photoImageView.layer.cornerRadius = 16
        //      photoImageView.layer.borderColor = UIColor.white.cgColor
        //       photoImageView.layer.borderWidth = 2.0
        
        //     photoImageView.clipsToBounds = false
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.15).cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        self.layer.shadowRadius = 21.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.masksToBounds = false
    }

}
