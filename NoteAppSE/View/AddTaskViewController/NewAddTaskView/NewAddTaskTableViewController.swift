//
//  NewAddTaskTableViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 18.01.2022.
//

import UIKit

enum NewTaskSection: Int {
    case Name = 0
    case Color = 1
    case Switcher = 2
    case Description = 3
    case Time = 4
}

enum DetentIdentifier {
    case large
    case medium
}

class NewAddTaskTableViewController: UITableViewController {
    
    var taskGroupsListTableViewController: TaskGroupsListViewController?
    var selectedCategory: Group?
    var todoListTableViewController: TodoListTableViewController?
    
    var rowInSection: [Int] = []
    var selectColor: String?
    var nameTask: String?
    var descriptionTask: String?
    var colors: [UIColor] = [UIColor.systemGreen, UIColor.systemRed, UIColor.systemBlue, UIColor.systemYellow, UIColor.systemOrange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        registerCell()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(hex: Colors.darkColor).cgColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(hex: Colors.darkColor).cgColor]
        
        title = "Новый список"
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor(hex: Colors.darkColor)
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(addTapped))
        
        if #available(iOS 13.0, *) {
            navigationItem.rightBarButtonItem?.tintColor = UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
        }
    }
    
    private func registerCell() {
        tableView.register(CustomColorTableViewCell.nib, forCellReuseIdentifier: CustomColorTableViewCell.identifier)
        tableView.register(CustomDetailTableViewCell.nib, forCellReuseIdentifier: CustomDetailTableViewCell.identifier)
        tableView.register(CustomTaskTableViewCell.nib, forCellReuseIdentifier: CustomTaskTableViewCell.identifier)
        tableView.register(CustomSwitcherTableViewCell.nib, forCellReuseIdentifier: CustomSwitcherTableViewCell.identifier)
    }
    
    @objc func addTapped() {
        let task: String = nameTask ?? "Empty"
        let color: String = selectColor ?? UIColor.systemBlue.toHexString()
        let taskModel = TaskModel(taskName: task, colorCell: color, completedTask: false)
        todoListTableViewController?.addTaskToTaskList(taskModel: taskModel)
        dismiss(animated: true, completion: nil)
        
    }
    
    func deleteCellTable() {
        rowInSection.remove(at: 0)
        tableView.beginUpdates()
        tableView.deleteRows(at: [IndexPath(row: 0, section: 3)], with: .automatic)
        tableView.endUpdates()
        sheetAnimate(.medium)
    }
    
    func addCellTable() {
        rowInSection.append(1)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath.init(row: rowInSection.count - 1, section: 3)], with: .automatic)
        tableView.endUpdates()
        sheetAnimate(.large)
    }
    
    func sheetAnimate(_ detent: DetentIdentifier) {
        if let sheet = navigationController?.sheetPresentationController {
            sheet.animateChanges {
                switch(detent) {
                case DetentIdentifier.large:
                    sheet.selectedDetentIdentifier = .large
                case DetentIdentifier.medium:
                    sheet.selectedDetentIdentifier = .medium
                }
            }
        }
    }
}



extension NewAddTaskTableViewController: CustomTaskTableViewCellDelegate, CustomDetailTableViewCellDelegate {
    func getDescriptionTask(cell: CustomDetailTableViewCell) {
        descriptionTask = cell.textView.text
    }
    
    func getNameTask(cell: CustomTaskTableViewCell) {
        nameTask = cell.textField.text
    }
}

