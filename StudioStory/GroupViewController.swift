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

//        let layer = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 364))
//        let gradient = CAGradientLayer()
//        gradient.frame = CGRect(x: 0, y: 0, width: 375, height: 364)
//        gradient.colors = [UIColor.black.cgColor,    UIColor.black.cgColor]
//        gradient.locations = [0, 1]
//        gradient.startPoint = CGPoint(x: 0.56, y: -0.82)
//        gradient.endPoint = CGPoint(x: 0.59, y: 1)
//        layer.layer.addSublayer(gradient)
//        self.view.addSubview(layer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GroupViewController: UICollectionViewDelegate {
    
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
