//
//  PhotoViewModel.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 07/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewModel {
    
    var image: UIImage?
    var description: String?
    var createDate: String?
    var groupName: String?
//    var imageMainColors: [UIColor]?
//    var imageMainHexColors: [String]?
    
    var photosPicker = PhotosPicker()

    
    convenience init(description: String? = nil, image: UIImage?, createDate: String, groupName: String? ) {
        self.init()
        self.description = description
        self.image = image
        self.createDate = createDate
        self.groupName = groupName
    }
    
    private func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d, YYYY"
        let dateString = dateFormatter.string(from: date)
        return "Uploaded \(dateString)"
    }
    
    func fetchPickedPhoto(groupName: String,completionHandler: @escaping (_ photoViewModel: PhotoViewModel?) -> Void) {
        var photoViewModel = PhotoViewModel()
        
        photosPicker.imagePickedBlock = { (image,date) in
            self.createDate = self.dateToString(date: date)
            photoViewModel = PhotoViewModel(image: image, createDate: self.createDate!, groupName: groupName)
      //      photos.append(photoViewModel)
            completionHandler(photoViewModel)
        }
    }

}
