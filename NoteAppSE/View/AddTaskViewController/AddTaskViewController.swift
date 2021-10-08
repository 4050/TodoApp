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
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)]
        appearance.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)]
        
        title = "Новая задача"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
        let task: String = textField.text!
        let color: String = selectColor!
        let taskModel = TaskModel(taskName: task, colorCell: color, completedTask: false)
        todoListTableViewController?.addTaskToTaskList(task: taskModel)
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            let indexPathCheckmark = IndexPath(row: checkmarkIndex ?? 0, section: 1)
            tableView.cellForRow(at: indexPathCheckmark)?.accessoryType = .none
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
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
}




/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


