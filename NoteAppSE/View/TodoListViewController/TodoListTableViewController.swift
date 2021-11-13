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

class TodoListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var groupList: GroupListModel?
    var taskList: [TaskModel]?
    var tableView = UITableView()
    var selectColor: UIColor?
    
    private let addButton: UIButton = {
        let button = UIButton()
        let boldLargeConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .bold, scale: .large)
        let smallConfig = UIImage.SymbolConfiguration(scale: .large)
        let boldSmallConfig = boldLargeConfig.applying(smallConfig)
        button.setTitle("Новая задача", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        //button.layer.backgroundColor = color?.cgColor()
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
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setupTableView()
        view.addSubview(addButton)
        addButton.backgroundColor = selectColor
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
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
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(CustomTableViewCell.nib, forCellReuseIdentifier:  CustomTableViewCell.identifier)
    }
    
    func setupNavigationBar() {
        title = groupList?.nameGroup
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: selectColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: selectColor]
        
        navigationItem.standardAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = selectColor
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
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(didTapApply))
        }
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
    
    @objc func didTapApply() {
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
