//
//  DropDownMenuButton.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 15/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class DropDownMenuButton: UIButton{//, dropDownProtocol {
    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    var dropView = DropDownView()
    
    var height = NSLayoutConstraint()
    
//    override func didMoveToSuperview() {
//        self.superview?.addSubview(dropView)
//        self.superview?.bringSubview(toFront: dropView)
//        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        height = dropView.heightAnchor.constraint(equalToConstant: 0)
//    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 150 {
                self.height.constant = 150
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
