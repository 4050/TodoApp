//
//  TaskGroupsListTableViewController + UITableView.swift
//  NoteAppSE
//
//  Created by Stanislav on 27.11.2021.
//

import Foundation
import UIKit

extension TaskGroupsListViewController: UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCategoryTableViewCell.identifier, for: indexPath) as! CustomCategoryTableViewCell
        cell.sheetNameLabel.text = groupList![indexPath.row].nameGroup
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if editingStyle == .delete {
            deleteCategory(indexPath: indexPath)
            setupValueCell()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [self] (_, _, completionHandler) in
            deleteCategory(indexPath: indexPath)
            setupValueCell()
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passData(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        groupList?.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func deleteCategory(indexPath: IndexPath) {
        guard let category = self.groupList?[indexPath.row] else { return }
        self.groupList?.remove(at: indexPath.row)
        categoryModel.deleteCategory(category: category)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension TaskGroupsListViewController: UITableViewDelegate {
    
}
