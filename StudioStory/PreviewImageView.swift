//
//  PreviewImageView.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 12/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class PreviewImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        configShadow()
    }
    
    private func configShadow() {
        
        self.layer.cornerRadius = 4
        //     photoImageView.clipsToBounds = false
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.08).cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 0, height: 4.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.masksToBounds = false
        self.clipsToBounds = true

    }
}
