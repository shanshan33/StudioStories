//
//  GroupsPreviewViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 22/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

enum CellType {
    case PreviewGroup
    case NewGroup
}

class GroupsPreviewViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    var newGroupIndexPath: IndexPath?
    
    var groupViewModels: [GroupViewModel] = []
 //   var groupViewModel = GroupViewModel()
    
    var photoViewModel = PhotoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if groupViewModels.isEmpty {
            groupViewModels.append(GroupViewModel(name: "New Album", thumbNails: [], numberOfPhotos: ""))
        }
//
//        groups = [Group(name: "Studio Work", photos: nil),
//                  Group(name: "Studio Loisir", photos: [PhotoStory(image: #imageLiteral(resourceName: "Studio_Skype"))]),
//                  Group(name: "Inspiration", photos: nil)]
        
//        photosPicker.imagePickedBlock = { (image,date) in
//            let story = PhotoStory(image: image, groupName:self.groupTitleTextField.text, createDate: date)
//            self.photoStories.append(story)
//            self.PhotosCollectionView.reloadData()
//            self.viewWillLayoutSubviews()
//        }
//        photoViewModel.groupBlock { (group) in
//            if let group = group {
//        //        let groupViewModel = GroupViewModel(name: group.name, thumbNails: group., numberOfPhotos: <#T##String?#>)
//                self.pictures.append(image)
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = ""
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAlbum" {
            if let photoViewController = segue.destination as? PhotoViewController {
                let index = groupCollectionView.indexPathsForSelectedItems?.first
                photoViewController.g
                
            }
//            photoViewController.groupBlock{ (group) -> () in
                
//            }
//                controller.selectedName = objects[indexPath.row]
//            }
        }
    }

    @IBAction func addNewGroup(_ sender: UIButton) {
        
        newGroupIndexPath = self.getNearestVisiableIndexPath(collectionView: groupCollectionView)
        self.groupCollectionView?.performBatchUpdates({
            groupViewModels.append(GroupViewModel(name: "New Album", thumbNails: [], numberOfPhotos: ""))
            guard let newGroupIndexPath = newGroupIndexPath else { return }
                self.groupCollectionView?.insertItems(at: [newGroupIndexPath])

        }, completion: nil)
    }
    
    private func getNearestVisiableIndexPath(collectionView: UICollectionView) -> IndexPath? {
        
        var visibleRect = CGRect()
        visibleRect.origin = groupCollectionView.contentOffset
        visibleRect.size = groupCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) else { return nil}
        return visibleIndexPath
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if (scrollView == groupCollectionView) {
//            snapToNearestVisiableCell(scrollView as! UICollectionView)
//        }
//    }
//
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        snapToNearestVisiableCell(scrollView as! UICollectionView)
    }

    
    func snapToNearestVisiableCell(_ collectionView: UICollectionView) {

        let visibleCenterPositionOfScrollView = Float(collectionView.contentOffset.x + (collectionView.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<collectionView.visibleCells.count {
            let cell = collectionView.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)
            
            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = collectionView.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            collectionView.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
    func isEmptyGroup(group: GroupViewModel) -> Bool {
       return group.thumbNails.isEmpty
    }
}

extension GroupsPreviewViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 325, height: 386)
    }

}

extension GroupsPreviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == newGroupIndexPath?.row {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyGroupCell", for: indexPath) as? EmptyGroupCell {
            cell.groupTitleLabel.text = "New Album"
            return cell
            }
        }
        
        if groupViewModels.count == 1 && isEmptyGroup(group: groupViewModels.first!) {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyGroupCell", for: indexPath) as? EmptyGroupCell {
                cell.groupTitleLabel.text = "New Album"
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupPreviewCell", for: indexPath) as! GroupPreviewCell
            if groupViewModels.count > 0 {
                cell.groupTitleLabel.text = groupViewModels[indexPath.row].name
            }
            return cell
        }
        return UICollectionViewCell()
    }    
}


