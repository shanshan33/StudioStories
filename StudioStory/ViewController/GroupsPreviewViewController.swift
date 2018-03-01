//
//  GroupsPreviewViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 22/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class GroupsPreviewViewController: UIViewController {

    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    var isAddingNewGroup: Bool = false
    
    var groups: [Group]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groups = [Group(name: "Studio Work", photos: nil),
                  Group(name: "Studio Loisir", photos: [PhotoStory(image: #imageLiteral(resourceName: "Studio_Skype"))]),
                  Group(name: "Inspiration", photos: nil)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.title = ""

    }

    @IBAction func addNewGroup(_ sender: UIButton) {
        var visibleRect = CGRect()
        visibleRect.origin = groupCollectionView.contentOffset
        visibleRect.size = groupCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let visibleIndexPath = groupCollectionView.indexPathForItem(at: visiblePoint) else { return }
        print(visibleIndexPath)
        
        isAddingNewGroup = true
 //       groupCollectionView.reloadData()
        
        self.groupCollectionView?.performBatchUpdates({
            groups?.append(Group(name: "New Album", photos: nil))
            self.groupCollectionView?.insertItems(at: [visibleIndexPath])
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GroupsPreviewViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 325, height: 386)
    }
    
    
    
    private func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (scrollView == groupCollectionView) {
           
            
        }
    }
}

extension GroupsPreviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (groups?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        if isAddingNewGroup {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyGroupCell", for: indexPath) as! EmptyGroupCell
            cell.groupTitleLabel.text = "New Album"
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupPreviewCell", for: indexPath) as! GroupPreviewCell
            cell.groupTitleLabel.text = groups![indexPath.row].name
            return cell
        }
        return cell
    }    
}


