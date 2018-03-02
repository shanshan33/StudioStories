//
//  GroupCell.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 19/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class PhotoStoryCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var groupTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCellShadow()
    
        photoImageView.clipsToBounds = true
        photoImageView.layer.cornerRadius = 4
    }
    
    private func createCellShadow() {
        self.layer.cornerRadius = 4
        self.contentView.layer.cornerRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.08).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
 //       self.layer.masksToBounds = false
 //       self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        
    }
}
