//
//  ViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 19/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

enum GroupSection {
    case photo
    case Button
}

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    var photosPicker = PhotosPicker()
    var pictures: [UIImage] = []
    
    @IBOutlet weak var PhotosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressToDelete))
        longPress.minimumPressDuration = 1
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        PhotosCollectionView.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photosPicker.imagePickedBlock = { (image) in
            self.pictures.append(image)
            self.PhotosCollectionView.reloadData()
        }
    }
    
    @IBAction func addPhotoButtonTaped(_ sender: UIButton) {
        photosPicker.viewController = self
        photosPicker.showActionSheet(from: self)
    }
    
    @objc func longPressToDelete(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != .ended {
            return
        }
        
        let point = gestureReconizer.location(in: self.PhotosCollectionView)
        let indexPath = self.PhotosCollectionView.indexPathForItem(at: point)
        if let index = indexPath {
            pictures.remove(at: index.row)
            PhotosCollectionView.deleteItems(at: [index])
            PhotosCollectionView.reloadData()
        } else {
            print("Could not find index path")
        }
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count > 0 ? pictures.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCell", for: indexPath) as! GroupCell
        if pictures.count > 0 {
            cell.groupCoverImageView.image = pictures[indexPath.row]
        }
        cell.layer.cornerRadius = 15
        return cell
    }
}
