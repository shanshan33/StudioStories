//
//  EditGroupsTableViewCell.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 14/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class EditGroupsTableViewCell: UITableViewCell {

    var groupViewModel = GroupViewModel()
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var numbersOfPhotosLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell(groupViewModel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(_ group: GroupViewModel) {
        self.groupNameLabel.text = group.name
        if let number = group.numberOfPhotos {
            self.numbersOfPhotosLabel.text = "∙ \(number)"
        }
    }
}
