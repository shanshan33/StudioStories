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

    @IBOutlet weak var selectGroupButton: DropDownMenuButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearence()
        addPhotoView.layer.cornerRadius = 16
        selectedPhotoImageView.layer.cornerRadius = 10
        selectedPhotoImageView.clipsToBounds = true
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
        setup(photo: photoViewModel)

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
