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
    var createDate: NSDate?
    var group: Group?
    
    init(image: UIImage?, group: Group? = nil, description:String? = nil, creator: String? = nil, createDate: NSDate? = nil) {
        self.image = image
        self.group = group
        self.description = description
        self.creator = creator
        self.createDate = createDate
    }
}
