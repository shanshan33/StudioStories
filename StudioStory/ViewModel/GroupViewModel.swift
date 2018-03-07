//
//  GroupViewModel.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 07/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation
import UIKit

struct GroupViewModel {
    var name: String?
    var photoThumbnails: [UIImage]
//    var photos: [PhotoStory]?
    
    init(name: String?, photoThumbnails: [UIImage]) {
        self.name = name
        self.photoThumbnails = photoThumbnails
    }
    
    
}
