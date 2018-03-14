//
//  EditGroupsViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 14/03/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

protocol EditGroupsViewControllerDelegate: class {
    func updateGroup(groupViewModel: GroupViewModel)
}

class EditGroupsViewController: UIViewController {
    
    var groupViewModels: [GroupViewModel] = []
    var delegate: EditGroupsViewControllerDelegate?
    @IBOutlet weak var editGroupsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarAppearence()
        editGroupsTableView.layer.cornerRadius = 16
        self.navigationController?.navigationBar.isHidden = false
        editGroupsTableView.isEditing = true

        let editButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action:#selector(showEditing))
        self.navigationItem.rightBarButtonItem = editButtonItem

    }
    
    private func setNavigationBarAppearence() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
  //      let group = GroupViewModel()
        
        if let selectedIndexPath = editGroupsTableView.indexPathForSelectedRow {
           let groupViewModel = groupViewModels[selectedIndexPath.row]
            editGroupsTableView.reloadRows(at: [selectedIndexPath], with: .none)
            delegate?.updateGroup(groupViewModel: groupViewModel)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showEditing(_ sender: UIBarButtonItem)
    {
        if(editGroupsTableView.isEditing == true) {
            editGroupsTableView.isEditing = false
            self.navigationItem.rightBarButtonItem?.title = "Done"
        }
        else {
            editGroupsTableView.isEditing = true
            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
    }
}

extension EditGroupsViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupViewModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension EditGroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditGroupsCell", for: indexPath) as! EditGroupsTableViewCell
        cell.setUpCell(groupViewModels[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        return .delete
//    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedGroup = self.groupViewModels[sourceIndexPath.row]
        groupViewModels.remove(at: sourceIndexPath.row)
        groupViewModels.insert(movedGroup, at: destinationIndexPath.row)
//        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(fruits)")
        print("\(sourceIndexPath.row) => \(destinationIndexPath.row) \(groupViewModels)")
        // To check for correctness enable: self.tableView.reloadData()
    }
}
