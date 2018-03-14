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

class GroupsPreviewViewController: UIViewController, UIScrollViewDelegate, photoViewControllerDelegate, EditGroupsViewControllerDelegate {

    @IBOutlet weak var groupCollectionView: ScalingCarouselView!
    
    var newGroupIndexPath: IndexPath?
    var selectedIndexPath: IndexPath?
    
    var groupViewModels: [GroupViewModel] = []
    
    var photoViewModel = PhotoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if groupViewModels.isEmpty {
            groupViewModels.append(GroupViewModel(name: "Inspiration Studio", photoViewModels: [], numberOfPhotos: 0))
        }
        
        groupCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        groupCollectionView.widthAnchor.constraint(equalToConstant: 375).isActive = true
        groupCollectionView.heightAnchor.constraint(equalToConstant: 456).isActive = true
        groupCollectionView.inset = 25
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = ""
        
    }
    
    func updateGroup(groupViewModel: GroupViewModel) {
        guard let selected = selectedIndexPath else { return }
        groupViewModels[selected.row] = groupViewModel
        groupCollectionView.reloadItems(at: [selected])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAlbum" {
            if let photoViewController = segue.destination as? PhotoViewController {
                photoViewController.delegate = self
                let index = groupCollectionView.indexPathsForSelectedItems?.first
                photoViewController.groupViewModel = groupViewModels[(index?.row)!]
            }
        }
        if segue.identifier == "editGroups" {
            if let editViewController = segue.destination as? EditGroupsViewController {
                editViewController.delegate = self
                editViewController.groupViewModels = groupViewModels
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        groupCollectionView.didScroll()
    }


    @IBAction func addNewGroup(_ sender: UIButton) {
        
        newGroupIndexPath = self.getNearestVisiableIndexPath(collectionView: groupCollectionView)
        self.groupCollectionView?.performBatchUpdates({
            guard let newGroupIndexPath = newGroupIndexPath else { return }
            self.groupCollectionView?.insertItems(at: [newGroupIndexPath])
            groupViewModels.insert(GroupViewModel(name: "New Album", photoViewModels: [], numberOfPhotos: 0), at: newGroupIndexPath.row)

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
        return (group.photoViewModels?.isEmpty)!
    }
}

extension GroupsPreviewViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 325, height: 386)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "goToAlbum", sender: indexPath)
    }

}

extension GroupsPreviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (groupViewModels[indexPath.row].photoViewModels?.isEmpty)! {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyGroupCell", for: indexPath) as? EmptyGroupCell {
                cell.groupTitleLabel.text = groupViewModels[indexPath.row].name ?? "New Album"
                return cell
            }
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupPreviewCell", for: indexPath) as! GroupPreviewCell
        if groupViewModels.count > 0 {
            cell.setCell(groupViewModel: groupViewModels[indexPath.row])
        }
        return cell
        
    }
}


