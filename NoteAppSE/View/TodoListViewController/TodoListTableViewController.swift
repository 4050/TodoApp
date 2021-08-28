//
//  TodoListViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 01.07.2021.
//

import Foundation
import UIKit

class TodoListTableViewController: UITableViewController {
    
    var groupList: GroupListModel?
    var taskList: [TaskModel]?
    private var taskListTableView = TodoListTableView()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        setupData()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.register(CustomTableViewCell.nib, forCellReuseIdentifier:  CustomTableViewCell.identifier)
        tableView.separatorColor = .clear
    }
    
    func setupData() {
        
    }
    
    
    func setupNavigationBar() {
        let image = UIImage(systemName: Image.gearshape)
        let imgBackArrow = UIImage(named: Image.imgBackArrow)
        
        title = groupList?.nameGroup
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.taskName.text = taskList![indexPath.row].taskName
        cell.delegate = self
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
            if cell.radioButton.isHighlighted {
                cell.radioButton.backgroundColor = .black
            } else {
                cell.radioButton.backgroundColor = .white
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            taskList?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
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
}

extension TodoListTableViewController: MyCellDelegate {
    func didTapButtonInCell(_ cell: CustomTableViewCell) {
        if cell.radioButtonTap {
            cell.radioButtonTap = false
            cell.taskName.isUserInteractionEnabled = true
            cell.radioButton.setImage(#imageLiteral(resourceName: "emptyRectangle"), for: .normal)
            cell.taskName.alpha = 1
        } else {
            cell.taskName.isUserInteractionEnabled = false
            cell.radioButtonTap = true
            cell.radioButton.setImage(#imageLiteral(resourceName: "fullRectangle"), for: .normal)
            cell.taskName.alpha = 0.5
        }
    }
}
