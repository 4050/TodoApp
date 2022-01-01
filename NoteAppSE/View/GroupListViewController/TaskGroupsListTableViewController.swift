//
//  TaskGroupsListTableViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 06.11.2021.
//

import UIKit

protocol GroupListViewControllerProtocol: AnyObject {
    func passData(index: Int)
}

class TaskGroupsListViewController: UIViewController {
    
    var groupList: [Group]?
    var categoryModel = CategoryModel()
    var tableView = UITableView()
    var dateService = DateService()
    var color: UIColor?
    var storageService = StorageService()

    
    private let addButton: UIButton = {
        let button = UIButton()
        if #available(iOS 15.0, *) {
            button.setTitle("Новый список", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
            button.configuration = .filled()
            button.configuration?.baseBackgroundColor = UIColor(hex: Colors.darkColor, alpha: 1.0)
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
        } else {
            button.setTitle("Новый список", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
            button.layer.backgroundColor = UIColor(hex: Colors.darkColor, alpha: 1.0).cgColor
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        return button
    }()

    override func viewDidLoad() {
        setNavigationBar()
        setupTableView()
        view.addSubview(tableView)
        view.addSubview(addButton)
        setupLayout()
        setupValueCell()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc func tapAddButton() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddGroupViewController") as! AddGroupViewController
        let navigationController = UINavigationController(rootViewController: vc)
        vc.taskGroupsListTableViewController = self
        navigationController.modalPresentationStyle = .automatic
        present(navigationController, animated: true)
    }
    
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 160).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "pencil.circle.fill"))
        tableView.register(CustomCategoryTableViewCell.nib, forCellReuseIdentifier: CustomCategoryTableViewCell.identifier)
    }

    func setNavigationBar() {
        let currentDate = setCurrentDate()
        title = currentDate
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backItem?.title = ""
        setRightBarButtonItem(buttonItem: .menu)
    }

    func setCurrentDate() -> String {
        return dateService.getCurrentDate()
    }

    func setContextMenu() -> UIMenu {
        let usersItem = UIAction(title: "Изменить расположение", image: UIImage(systemName: "arrow.up.arrow.down.circle")) { (action) in
            self.didTapSort()
        }
        let menu = UIMenu(options: .displayInline, children: [usersItem])
        return menu
    }

    func setRightBarButtonItem(buttonItem: BarButtonItem) {
        switch buttonItem {
        case .menu:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image:  UIImage(systemName: "gearshape"), menu: setContextMenu())
            navigationItem.rightBarButtonItem?.tintColor = .black
        case .apply:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(didTapApply))
            navigationItem.rightBarButtonItem?.tintColor = .black
        case .save:
            break
        }
    }

    func didTapSort() {
        UIView.animate(withDuration: 0.17,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
            self!.tableView.isEditing = true
            self!.setRightBarButtonItem(buttonItem: .apply)
            self!.addButton.alpha = 0
        }, completion: nil)
    }

    @objc func didTapApply() {
        UIView.animate(withDuration: 0.17,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: { [weak self] in
            self!.tableView.isEditing = false
            self!.setRightBarButtonItem(buttonItem: .menu)
            self!.addButton.alpha = 1
        }, completion: nil)
    }
    
    func setupValueCell() {
        groupList = categoryModel.getCategoryList()
    }
    
    func addGroupToGroupList(category: CategoryModel) {
        categoryModel.saveGroup(category: category)
        setupValueCell()
        tableView.reloadData()
    }
    
    func passData(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "TodoListTableViewController") as? TodoListTableViewController else { return }
        vc.groupList = groupList?[index]
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectedCategory = groupList?[indexPath.row]
        }

        vc.selectColor = UIColor(hex: groupList![index].colorGroup ?? "#9992ff")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setColor(_ color: String) -> UIColor {
        return UIColor(hex: color, alpha: 1.0)
    }
}
