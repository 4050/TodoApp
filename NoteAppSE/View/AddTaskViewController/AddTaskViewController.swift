//
//  AddTaskViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 19.09.2021.
//

import UIKit

class AddTaskViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var colorView: UIView!
    
    var selectColor: String?
    var checkmarkIndex: Int?
    
    var todoListTableViewController: TodoListTableViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: Colors.defaultColor.cgColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.defaultColor.cgColor]
        
        title = "Новая задача"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = Colors.defaultColor
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let task: String = textField.text ?? "Empty"
        let color: String = selectColor ?? UIColor.systemBlue.toHexString()
        let taskModel = TaskModel(taskName: task, colorCell: color, completedTask: false)
        todoListTableViewController?.addTaskToTaskList(task: taskModel)
        dismiss(animated: true, completion: nil)
    }
    
    func selectCellColor(indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath) != nil {
            switch indexPath {
            case IndexPath(row: 0, section: 1):
                checkmarkIndex = 0
                return selectColor = UIColor.systemGreen.toHexString()
            case IndexPath(row: 1, section: 1):
                checkmarkIndex = 1
                return selectColor = UIColor.systemRed.toHexString()
            case IndexPath(row: 2, section: 1):
                checkmarkIndex = 2
                return selectColor = UIColor.systemBlue.toHexString()
            case IndexPath(row: 3, section: 1):
                checkmarkIndex = 3
                return selectColor = UIColor.systemYellow.toHexString()
            default:
                return selectColor = UIColor.systemGray.toHexString()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            selectColor = nil
        } else {
            let indexPathCheckmark = IndexPath(row: checkmarkIndex ?? 0, section: 1)
            tableView.cellForRow(at: indexPathCheckmark)?.accessoryType = .none
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            selectCellColor(indexPath: indexPath)
        }
    }
}

