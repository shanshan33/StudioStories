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
    
    private func configCellUI() {
//        let layer = UIView(frame: self.frame)
//        layer.layer.cornerRadius = 16
//        layer.backgroundColor = UIColor.white
//        let shadow0 = UIView(frame: CGRect(x: 0, y: 0, width: 325, height: 386))
//        shadow0.layer.cornerRadius = 16
//        shadow0.layer.shadowOffset = CGSize(width: 0, height: 8)
//        shadow0.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.15).cgColor
//        shadow0.layer.shadowOpacity = 1
//        shadow0.layer.shadowRadius = 21
//        layer.addSubview(shadow0)
//
//        let shadow1 = UIView(frame: CGRect(x: 0, y: 0, width: 325, height: 386))
//        shadow1.layer.cornerRadius = 16
//        shadow1.layer.shadowOffset = CGSize(width: 0, height: 2)
//        shadow1.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.12).cgColor
//        shadow1.layer.shadowOpacity = 1
//        shadow1.layer.shadowRadius = 2
//        layer.addSubview(shadow1)
//
//        let shadow2 = UIView(frame: CGRect(x: 0, y: 0, width: 325, height: 386))
//        shadow2.layer.cornerRadius = 16
//        shadow2.layer.shadowOffset = CGSize(width: 0, height: 4)
//        shadow2.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.15).cgColor
//        shadow2.layer.shadowOpacity = 1
//        shadow2.layer.shadowRadius = 7
//        layer.addSubview(shadow2)
//        self.addSubview(layer)
//
        self.layer.cornerRadius = 16
        self.contentView.layer.cornerRadius = 16
        self.contentView.layer.borderWidth = 1.0
    
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.12).cgColor

        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
}
