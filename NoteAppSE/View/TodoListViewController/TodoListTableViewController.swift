//
//  TodoListViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 01.07.2021.
//

import Foundation
import UIKit

enum BarButtonItem {
    case menu
    case apply
}

class TodoListTableViewController: UIViewController {
    
    var groupList: GroupListModel?
    var taskList: [TaskModel]?
    var tableView = TodoListTableView()
    var todoListTableView: TodoListTableView?
    
    var color: UIColor?
    
    private let addButton: UIButton = {
        let button = UIButton()
        let boldLargeConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .bold, scale: .large)
        let smallConfig = UIImage.SymbolConfiguration(scale: .large)
        let boldSmallConfig = boldLargeConfig.applying(smallConfig)
        button.setTitle("Новая задача", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        button.layer.backgroundColor = #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 1.0
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        tableView = TodoListTableView(frame: .zero, style: .insetGrouped)
        //tableView.delegate = self
        //tableView.dataSource = self
        view.addSubview(tableView)
        setupValueCell()
        setupTableView()
        view.addSubview(addButton)
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func tapAddButton() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddTaskViewController") as! AddTaskViewController
        let navigationController = UINavigationController(rootViewController: vc)
        vc.todoListTableViewController = self
        navigationController.modalPresentationStyle = .automatic
        present(navigationController, animated: true)
    }
    
    func setupTableView() {
        //tableView.backgroundColor = #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)
       // tableView.separatorColor = .clear
       // tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        //tableView.register(CustomTableViewCell.nib, forCellReuseIdentifier:  CustomTableViewCell.identifier)
    }
    
    func setupNavigationBar() {
        title = groupList?.nameGroup
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)]
        appearance.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)]
        
        navigationItem.standardAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        setupRightBarButtonItem(buttonItem: .menu)
    }
    
    func setupContextMenu() -> UIMenu {
        let usersItem = UIAction(title: "Изменить расположение", image: UIImage(systemName: "arrow.up.arrow.down.circle")) { (action) in
            self.didTapSort()
        }
        let menu = UIMenu(options: .displayInline, children: [usersItem])
        return menu
    }
    
    func setupRightBarButtonItem(buttonItem: BarButtonItem) {
        switch buttonItem {
        case .menu:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage(systemName: "gearshape"), menu: setupContextMenu())
        case .apply:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(tap))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func selectColor(color: UIColor) {
        self.color = color
    }
    
    func setupValueCell() {
        todoListTableView?.setupValueCell(taskList: taskList!)
    }
    
    func didTapSort() {
        UIView.animate(withDuration: 0.17,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            self!.tableView.isEditing = true
            self!.setupRightBarButtonItem(buttonItem: .apply)
            self!.addButton.alpha = 0
        }, completion: nil)
    }
    
    @objc func tap() {
        UIView.animate(withDuration: 0.17,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: { [weak self] in
            self!.tableView.isEditing = false
            self!.setupRightBarButtonItem(buttonItem: .menu)
            self!.addButton.alpha = 1
        }, completion: nil)
    }
    
    func addTaskToTaskList(task: TaskModel) {
        taskList?.append(task)
        tableView.reloadData()
    }
}


extension TodoListTableViewController {
 //   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 //       return taskList?.count ?? 0
 //   }
 //
 //   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 //       let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! //CustomTableViewCell
 //       cell.taskName.text = taskList![indexPath.row].taskName
 //       let color = UIColor(hex: taskList![indexPath.row].colorCell ?? "")
 //       cell.customColor = color
 //       if cell.radioButtonTap == false {
 //           cell.setupEmptyRadioButton()
 //       }
 //       cell.delegate = self
 //       cell.layer.masksToBounds = true
 //       cell.selectionStyle = .none
 //       return cell
 //
 //   }
 //
 //   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 //       return 50.0;
 //   }
 //
 //   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 //       if editingStyle == .delete {
 //           taskList?.remove(at: indexPath.row)
 //           tableView.deleteRows(at: [indexPath], with: .fade)
 //       }
 //   }
 //
 //   func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
 //   -> UISwipeActionsConfiguration? {
 //       let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
 //           self.taskList?.remove(at: indexPath.row)
 //           tableView.deleteRows(at: [indexPath], with: .fade)
 //           completionHandler(true)
 //       }
 //       deleteAction.image = UIImage(systemName: "trash")
 //       deleteAction.backgroundColor = .systemRed
 //       let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
 //       return configuration
 //   }
 //
 //   func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 //       return true
 //   }
 //
 //   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
 //       taskList?.swapAt(sourceIndexPath.row, destinationIndexPath.row)
 //   }
}

extension TodoListTableViewController: MyCellDelegate {
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
