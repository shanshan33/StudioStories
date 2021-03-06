//
//  DropDownView.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 15/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

protocol DropDownViewDelegate: class {
    func dropDownPressed(string : String)
}

class DropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {

    var dropDownOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate: DropDownViewDelegate?
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//
//        tableView.backgroundColor = UIColor.darkGray
//        self.backgroundColor = UIColor.darkGray
//
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.addSubview(tableView)
//
//        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.dropDownPressed(string:dropDownOptions[indexPath.row]
        )
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}
