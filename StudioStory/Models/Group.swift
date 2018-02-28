//
//  Group.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 28/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

public struct Group {
    var name: String?
    var photos: [PhotoStory]?
    
    init(name: String?, photos: [PhotoStory]?) {
        self.name = name
        self.photos = photos
    }
}



