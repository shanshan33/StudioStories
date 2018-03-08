//
//  GroupViewModel.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 07/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation
import UIKit

class GroupViewModel {
    var name: String?
    var numberOfPhotos: String?
    var photos: [UIImage]
    
    init(name: String?, photos: [UIImage], numberOfPhotos: String?) {
        self.name = name
        self.photos = photos
        self.numberOfPhotos = numberOfPhotos
    }
    
//    convenience init(group: Group) {
//        self.init()
//        self.name = group.name
//        self.numberOfPhotos = formatNumberOfPhotos(number: group.numberOfPhoto!)
// //       self.thumbNails = thumbnails(width: 80, photos: group.thumbnails)
//    }
    
    private func formatNumberOfPhotos(number: Int) -> String {
        return number > 0 ? "∙ \(number)" : ""
    }
    
    func thumbnails(width: CGFloat, photos:[PhotoViewModel]) -> [UIImage] {
        var newPhotos: [UIImage] = []
        for photo in photos {
            if let resizePhoto = photo.image?.resizeBy(width: width) {
            newPhotos.append(resizePhoto)
            }
        }
        return newPhotos
    }
    
}
