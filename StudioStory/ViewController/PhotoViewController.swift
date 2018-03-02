//
//  ViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 19/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//


import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    var photosPicker = PhotosPicker()
    var pictures: [UIImage] = []
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var PhotosCollectionView: UICollectionView!
    @IBOutlet weak var groupPhotoViewHeader: UIView!
    @IBOutlet weak var groupPhotosView: UIView!
    
    @IBOutlet weak var groupTitleTextField: UITextField! {
        didSet {
            groupTitleTextField.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearence()
        groupPhotosView.layer.cornerRadius = 16
        groupPhotoViewHeader.layer.cornerRadius = 16
        self.navigationController?.navigationBar.isHidden = false
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressToDelete))
        longPress.minimumPressDuration = 3
        longPress.delaysTouchesBegan = true
        longPress.delegate = self
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: PhotosCollectionView)
        }
        PhotosCollectionView.addGestureRecognizer(longPress)
        
        if let layout = PhotosCollectionView.collectionViewLayout as? PhotoStoryLayout {
            layout.delegate = self
        }
        
        if (groupTitleTextField.text?.isEmpty)! {
            groupTitleTextField.becomeFirstResponder()
        }
    }
    
    private func setNavigationBarAppearence() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photosPicker.imagePickedBlock = { (image) in
            self.pictures.append(image)
            self.PhotosCollectionView.reloadData()
            self.viewWillLayoutSubviews()
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        PhotosCollectionView.collectionViewLayout.invalidateLayout()
    }
}

extension PhotoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
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
}

extension PhotoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count > 0 ? pictures.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoStoryCell", for: indexPath) as! PhotoStoryCell
        if pictures.count > 0 {
            cell.photoImageView.image = pictures[indexPath.row]
        }
  //      cell.layer.cornerRadius = 4
        return cell
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toGallery", sender: indexPath)

    }
}

//MARK: - PINTEREST LAYOUT DELEGATE
extension PhotoViewController: PhotoStoryLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return pictures[indexPath.item].size.height
    }
    
    func collectionView(_ collectionView: UICollectionView, widthForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return pictures[indexPath.item].size.width
    }
    
}
