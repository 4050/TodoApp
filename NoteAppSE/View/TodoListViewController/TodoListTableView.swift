////
////  TodoListTableView.swift
////  NoteAppSE
////
////  Created by Stanislav on 01.07.2021.
////
//
//import UIKit
//
//class TodoListTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
//    
//    var groupList: GroupListModel?
//    var taskList: [TaskModel]?
//    
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
//        delegate = self
//        dataSource = self
//        setupTableView()
//        reloadData()
//        print("TABLEVIEW")
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    func setupValueCell(groupList: GroupListModel?, taskList: [TaskModel]?) {
//        self.groupList = groupList
//        self.taskList = taskList
//    }
//    
//    func setupTableView() {
//        register(CustomTableViewCell.nib, forCellReuseIdentifier:  CustomTableViewCell.identifier)
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return taskList?.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
//        cell.taskName.text = taskList![indexPath.row].taskName
//        //cell.delegate = self
//        cell.layer.masksToBounds = true
//        cell.selectionStyle = .none
//        
//        return cell
//        
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 50.0;
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
//            if cell.radioButton.isHighlighted {
//                cell.radioButton.backgroundColor = .black
//            } else {
//                cell.radioButton.backgroundColor = .white
//            }
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            taskList?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
//    -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
//            self.taskList?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            completionHandler(true)
//        }
//        deleteAction.image = UIImage(systemName: "trash")
//        deleteAction.backgroundColor = .systemRed
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
//        return configuration
//    }
//}
