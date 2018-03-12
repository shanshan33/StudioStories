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
    
    var groupViewModel = GroupViewModel()
    var images: [UIImage] = []
    var imageViews: [UIImageView] = []
    
    override func awakeFromNib() {
        setCell(groupViewModel: groupViewModel)
        
        for subview in imagePreviewStackView.subviews {
            for items in subview.subviews {
                if let imageView = items as? UIImageView{
  //                  imageView.layer.cornerRadius = 4
  //                  imageView.contentMode = .scaleAspectFill
  //                  imageView.clipsToBounds = true
                    imageViews.append(imageView)
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configCellAppearence()
    }

    func setCell(groupViewModel: GroupViewModel) {
        groupTitleLabel.text = groupViewModel.name
        numberOfPhotosLabel.text = groupViewModel.numberOfPhotos
        if let models = groupViewModel.photoViewModels {
            for photoViewModel in models {
                self.images.append(photoViewModel.image!)
            }
            for i in 0..<self.images.count{
                imageViews[i].image = self.images[i]
            }
        }
    }

    private func configImagePreview() {
        for i in 0..<self.images.count{
            imageViews[i].image = self.images[i]
  //          createShadow(imageView: imageViews[i])
        }
    }
    
    private func createShadow(imageView: UIImageView) {
        imageView.layer.cornerRadius = 4
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.08).cgColor
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 10
 //       imageView.layer.masksToBounds = false
        imageView.layer.shadowPath = UIBezierPath(rect: imageView.bounds).cgPath
    }
    
        func configCellAppearence() {
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
