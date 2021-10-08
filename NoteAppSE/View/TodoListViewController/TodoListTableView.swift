//
//  TodoListTableView.swift
//  NoteAppSE
//
//  Created by Stanislav on 01.07.2021.
//

import UIKit

class TodoListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var groupList: GroupListModel?
    var taskList: [TaskModel]?
    var tableView = UITableView()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        setupTableView()
        reloadData()
        print("TABLEVIEW")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupTableView() {
        //tableView.backgroundColor = #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.nib, forCellReuseIdentifier:  CustomTableViewCell.identifier)
    }
    
    func setupValueCell(groupList: GroupListModel?, taskList: [TaskModel]?) {
        self.groupList = groupList
        self.taskList = taskList
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.taskName.text = taskList![indexPath.row].taskName
        let color = UIColor(hex: taskList![indexPath.row].colorCell ?? "")
        cell.customColor = color
        if cell.radioButtonTap == false {
            cell.setupEmptyRadioButton()
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
            taskList?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.taskList?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        taskList?.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func setupValueCell(taskList: [TaskModel]) {
        self.taskList = taskList
    }
}

extension TodoListTableView: MyCellDelegate {
    func didTapButtonInCell(_ cell: CustomTableViewCell) {
        if cell.radioButtonTap {
            cell.radioButtonTap = false
            cell.taskName.isUserInteractionEnabled = true
            cell.setupEmptyRadioButton()
            cell.taskName.alpha = 1
        } else {
            cell.taskName.isUserInteractionEnabled = false
            cell.radioButtonTap = true
            cell.setupFullRadioButton()
            cell.taskName.alpha = 0.5
        }
    }
}
