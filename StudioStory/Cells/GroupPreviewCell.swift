//
//  GroupPreviewCell.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 22/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class GroupPreviewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePreviewStackView: UIStackView!
    
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var numberOfPhotosLabel: UILabel!
    
    override func awakeFromNib() {
        configCellUI()
    }
    
    func setCell(group: Group) {
        groupTitleLabel.text = group.name
    }
    private func configCellUI() {
        for subview in imagePreviewStackView.subviews {
            for item in subview.subviews {
                if let imageView = item as? UIImageView {
                    imageView.layer.cornerRadius = 20
                }
            }
        }
        
        self.layer.cornerRadius = 16
        self.contentView.layer.cornerRadius = 16
    
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.15).cgColor

        self.layer.shadowOffset = CGSize(width: 0, height: 8.0)
        self.layer.shadowRadius = 21
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
}
