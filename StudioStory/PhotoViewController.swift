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

@available(iOS 9.0, *)
public protocol UIPreviewActionItem : NSObjectProtocol {
    var title: String { get }
}

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    var photosPicker = PhotosPicker()
    var pictures: [UIImage] = []
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var PhotosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressToDelete))
        longPress.minimumPressDuration = 3
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: PhotosCollectionView)
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        guard let photoGalleryViewController  = segue.destination as? PhotoGalleryViewController else { return }
        photoGalleryViewController.pickedImage = pictures[indexPath.row]
    }
}

extension PhotoViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = self.PhotosCollectionView.indexPathForItem(at: location) else { return nil }
        //  It's much better to use layoutAttributesForItem than cellForItem. this will show the cell clearly and blur the rest of the screen for our peek
        //  guard let cell = self.PhotosCollectionView.cellForItem(at: indexPath) as? GroupCell else { return nil }
        guard let cellAttributes = self.PhotosCollectionView.layoutAttributesForItem(at: indexPath) else { return nil }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let photoGallery = storyboard.instantiateViewController(withIdentifier: "PhotoGalleryViewController") as? PhotoGalleryViewController else { return nil }
        
        let photo = pictures[indexPath.row]
        photoGallery.pickedImage = photo
        photoGallery.preferredContentSize = CGSize(width: 0.0, height: 500)
        previewingContext.sourceRect = cellAttributes.frame
        return photoGallery
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
  //      show(viewControllerToCommit, sender: self)
        present(viewControllerToCommit, animated: true, completion: nil)
    }
    
    func previewActionItems() -> [UIPreviewActionItem] {
        
        let likeAction = UIPreviewAction(title: "Like", style: .default) { (action, viewController) -> Void in
            print("You liked the photo")
        }
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) -> Void in
            print("You deleted the photo")
        }
        return []
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
        cell.layer.cornerRadius = 10
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toGallery", sender: indexPath)

    }
    
}
