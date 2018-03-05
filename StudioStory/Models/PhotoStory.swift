//
//  Photo.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 28/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

public struct PhotoStory {
    var image: UIImage?
    var description: String?
    var creator: String?
    var createDate: Date?
    var groupName: String?
    
    init(image: UIImage?, groupName: String? = nil, description:String? = nil, creator: String? = nil, createDate: Date? = nil) {
        self.image = image
        self.groupName = groupName
        self.description = description
        self.creator = creator
        self.createDate = createDate
    }
}
