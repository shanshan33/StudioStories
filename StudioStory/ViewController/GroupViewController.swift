//
//  GroupViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 22/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GroupViewController: UICollectionViewDelegate {
 
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

extension GroupViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupPreviewCell", for: indexPath) as! GroupPreviewCell
        return cell
    }    
}


