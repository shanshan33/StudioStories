//
//  dropDownButton.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 16/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit


class dropDownButton: UIButton, DropDownViewDelegate {
    var menuOpened = false
    var dropView = DropDownView()
    var height = NSLayoutConstraint()

    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    func dismissDropDown() {
        menuOpened = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
//    override func awakeFromNib() {
//        
//        dropView = DropDownView.init(frame: CGRect.init(x: 26, y: 300, width: 325, height: 0))
//        dropView.delegate = self
//        dropView.translatesAutoresizingMaskIntoConstraints = false
//    }
//    override func didMoveToSuperview() {
//        self.superview?.addSubview(dropView)
//        self.superview?.bringSubview(toFront: dropView)
//        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        height = dropView.heightAnchor.constraint(equalToConstant: 0)
//    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                if menuOpened == false {
                    menuOpened = true
                    NSLayoutConstraint.deactivate([self.height])
        
                    if dropView.tableView.contentSize.height > 150 {
                        self.height.constant = 150
                    } else {
                        self.height.constant = 200 //self.dropView.tableView.contentSize.height
                    }
        
        
                    NSLayoutConstraint.activate([self.height])
        
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.dropView.layoutIfNeeded()
                        self.dropView.center.y += self.dropView.frame.height / 2
                    }, completion: nil)
        
                } else {
                    menuOpened = false
        
                    NSLayoutConstraint.deactivate([self.height])
                    self.height.constant = 0
                    NSLayoutConstraint.activate([self.height])
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                        self.dropView.center.y -= self.dropView.frame.height / 2
                        self.dropView.layoutIfNeeded()
                    }, completion: nil)
        
                }
        
        layoutIfNeeded()
    }
    

}
