//
//  EmptyGroupCell.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 28/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class EmptyGroupCell: ScalingCarouselCell {
    
    @IBOutlet weak var groupTitleLabel: UILabel!
    
    override func awakeFromNib() {
        configCellUI()
    }
    private func configCellUI() {
        
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
