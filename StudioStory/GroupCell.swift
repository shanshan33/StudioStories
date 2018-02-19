//
//  GroupCell.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 19/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class GroupCell: UICollectionViewCell {
    
    @IBOutlet weak var groupCoverImageView: UIImageView!
    @IBOutlet weak var groupTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        groupCoverImageView.clipsToBounds = true
        groupCoverImageView.layer.cornerRadius = 10
    }
    
//    func configureCell(noodle: Noodle){
//        noodleImageView.image = noodle.image
//        noodleNameLabel.text  = noodle.title
//        restaurantLabel.text  = noodle.restaurantName
//    }
    
}
