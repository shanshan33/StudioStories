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

    @IBOutlet weak var characterCountLabel: UILabel!
    var groupViewModels: [GroupViewModel] = []
    @IBOutlet weak var chooseGroupButton: UIButton!
    @IBOutlet weak var chooseGroupTableView: UITableView!
    @IBOutlet weak var dropTableviewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addPhotoScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearence()
        addPhotoView.layer.cornerRadius = 16
        selectedPhotoImageView.layer.cornerRadius = 10
        
        selectedPhotoImageView.clipsToBounds = true
        chooseGroupTableView.layer.borderWidth = 1.0
        chooseGroupTableView.layer.borderColor = #colorLiteral(red: 0.8763179183, green: 0.8769848943, blue: 0.8764212728, alpha: 1)
        chooseGroupTableView.layer.cornerRadius = 5
        
        descriptionTextView.layer.borderColor = #colorLiteral(red: 0.8763179183, green: 0.8769848943, blue: 0.8764212728, alpha: 1)
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 5
        
        characterCountLabel.layer.masksToBounds = true
        characterCountLabel.layer.cornerRadius = 10
        characterCountLabel.text = "120"

        chooseGroupButton.contentHorizontalAlignment = .left
        chooseGroupButton.setTitle(groupViewModels.first?.name, for: .normal)
        chooseGroupTableView.translatesAutoresizingMaskIntoConstraints = false
        dropTableviewHeightConstraint.constant = 50
    }
    
    func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.chooseGroupTableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    @IBAction func clickDropDownMenuAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.dropTableviewHeightConstraint.constant = 182
        }, completion: nil)
        self.view.layoutIfNeeded()
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
//        chooseGroupButton.widthAnchor.constraint(equalToConstant: 325).isActive = true
//        chooseGroupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
  //      chooseGroupButton.dropView.dropDownOptions = groupViewModels.map{$0.name!}
  //      chooseGroupButton.dropView.backgroundColor = .red
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

extension AddPhotoViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        addPhotoScrollView.setContentOffset(.zero, animated: true)
        textView.resignFirstResponder()

    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        if newText.count <= 120 {
            characterCountLabel.text = "\(120 - newText.count)"
        }
        if(text == "\n")  {
            textView.resignFirstResponder()
            addPhotoScrollView.setContentOffset(.zero, animated: true)
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let scrollPoint = CGPoint(x:0, y: 50)
        addPhotoScrollView.setContentOffset(scrollPoint, animated: true)
    }
}

extension AddPhotoViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = groupViewModels[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chooseGroupButton.setTitle(groupViewModels[indexPath.row].name, for: .normal)
        UIView.animate(withDuration: 0.5, animations: {
            self.dropTableviewHeightConstraint.constant = 50
        }, completion: nil)
        self.view.layoutIfNeeded()
        self.chooseGroupTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
