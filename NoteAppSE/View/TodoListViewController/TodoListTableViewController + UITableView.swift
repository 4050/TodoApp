//
//  TodoListTableViewController + UITableView.swift
//  NoteAppSE
//
//  Created by Stanislav on 14.10.2021.
//

import Foundation
import UIKit

extension TodoListTableViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskLists.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        let color = UIColor(hex: taskLists[indexPath.row].colorTask ?? "")

        cell.taskName.text = taskLists[indexPath.row].nameTask
        cell.customColor = color
        cell.taskName.tag = indexPath.row
        print(taskLists[indexPath.row].completedTask)
        if taskLists[indexPath.row].completedTask == true {
            cell.setupFullRadioButton()
            cell.taskName.alpha = 0.5
        } else {
            cell.setupEmptyRadioButton()
            cell.taskName.alpha = 1
        }
        cell.delegate = self
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [self] (_, _, completionHandler) in
            deleteItem(indexPath: indexPath)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        taskLists.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func deleteItem(indexPath: IndexPath) {
        let task = self.taskLists[indexPath.row]
        self.taskLists.remove(at: indexPath.row)
        taskListModel.deleteTask(task: task)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

