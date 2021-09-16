//
//  TodoListViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 01.07.2021.
//

import Foundation
import UIKit

class TodoListTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var groupList: GroupListModel?
    var taskList: [TaskModel]?
    var tableView = UITableView()
    
    private let addButton: UIButton = {
        let button = UIButton()
        let boldLargeConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .bold, scale: .large)
        let smallConfig = UIImage.SymbolConfiguration(scale: .large)
        let boldSmallConfig = boldLargeConfig.applying(smallConfig)
        button.setImage(UIImage(systemName: "plus", withConfiguration: boldSmallConfig), for: UIControl.State.normal)
        button.setTitle("Добавить список", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        view.addSubview(tableView)

        tableView.register(CustomTableViewCell.nib, forCellReuseIdentifier:  CustomTableViewCell.identifier)
        
        view.addSubview(addButton)
        //addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        //addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    @objc func tapAddButton() {
        print("123")
    }
    
    func setupTableView() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupNavigationBar() {
        let image = UIImage(systemName: Image.gearshape)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.taskName.text = taskList![indexPath.row].taskName
        cell.delegate = self
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        return cell

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell {
            if cell.radioButton.isHighlighted {
                cell.radioButton.backgroundColor = .black
            } else {
                cell.radioButton.backgroundColor = .white
            }
        }
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
