//
//  AddPhotoViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 15/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {

    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var selectedPhotoImageView: UIImageView!
    var photosPicker = PhotosPicker()
    var photoViewModel = PhotoViewModel()

    var groupViewModels: [GroupViewModel] = []
    @IBOutlet weak var selectGroupButton: DropDownMenuButton!
    @IBOutlet weak var chooseGroupButton: dropDownButton!
    
    @IBOutlet weak var dropButtonCloseHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearence()
        addPhotoView.layer.cornerRadius = 16
        selectedPhotoImageView.layer.cornerRadius = 10
        selectedPhotoImageView.clipsToBounds = true
        chooseGroupButton.height = dropButtonCloseHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        photoViewModel.fetchPickedPhoto(groupName: title) { (photo) in
//            if let image = photo?.image {
//                self.pictures.append(image)
//            }
//            self.photoViewModels.append(photo!)
//            self.PhotosCollectionView.reloadData()
//            self.viewWillLayoutSubviews()
//        }
        chooseGroupButton.setTitle(groupViewModels.first?.name, for: .normal)
        setup(photo: photoViewModel)
        chooseGroupButton.widthAnchor.constraint(equalToConstant: 325).isActive = true
        chooseGroupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        chooseGroupButton.dropView.dropDownOptions = groupViewModels.map{$0.name!}
    }
    
    private func setup(photo: PhotoViewModel) {
        self.selectedPhotoImageView.image = photo.image
    }
    
    @IBAction func dismissViewController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    private func setNavigationBarAppearence() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
}
