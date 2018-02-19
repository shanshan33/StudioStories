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

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var photosPicker = PhotosPicker()
    var pictures: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        photosPicker.imagePickedBlock = { (image) in
            self.pictures.append(image)
            self.PhotosCollectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var PhotosCollectionView: UICollectionView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPhotoButtonTaped(_ sender: UIButton) {

//        if imagePicker.isSourceTypeAvailable(.photoLibrary) {
//            imagePicker.allowsEditing = false
//            imagePicker.sourceType = .photoLibrary
//            present(imagePicker, animated: true, completion: nil)
//        }
        photosPicker.viewController = self
        photosPicker.showActionSheet(from: self)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
//    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
 //           imageView.contentMode = .ScaleAspectFit
 //           imageView.image = pickedImage
 //       }
        
 //       dismiss(animated: true, completion: nil)
 //   }
    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
    
}

extension PhotoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count > 0 ? pictures.count : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCell", for: indexPath) as! GroupCell
//        cell.configureCell(noodle: ramens[indexPath.row])
        if pictures.count > 0 {
            cell.groupCoverImageView.image = pictures[indexPath.row]
        }
        cell.layer.cornerRadius = 15
        return cell
    }
}
