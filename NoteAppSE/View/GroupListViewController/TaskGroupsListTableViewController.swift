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

class TaskGroupsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var groupList: [Group]?
    private var categoryModel = CategoryModel()
    private var tableView = UITableView()
    private var dateService = DateService()
    private var color: UIColor?
    private var storageService = StorageService()

    
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
        tableView.register(CustomCollectionViewCell.nib, forCellReuseIdentifier:  CustomCollectionViewCell.identifier)
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
        groupList = StorageService.shared.getGroupTasks()
        //groupList = categoryModel.getCategoryList()
    }
    
    func addGroupToGroupList(category: CategoryModel) {
        StorageService.shared.saveGroupTasks(category: category)
        //categoryModel.saveGroup(category: category)
        setupValueCell()
        tableView.reloadData()
    }
    
    func passData(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "TodoListTableViewController") as? TodoListTableViewController else { return }
        vc.groupList = groupList?[index]
        //vc.taskList = groupList![index].taskList?.allObjects as? [TaskModel]
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectedCategory = groupList?[indexPath.row]
            print("SELECTEDCATEGORY\(groupList?[indexPath.row])")
        }

        vc.selectColor = UIColor(hex: groupList![index].colorGroup ?? "#9992ff")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setColor(_ color: String) -> UIColor {
        return UIColor(hex: color, alpha: 1.0)
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.sheetNameLabel.text = groupList![indexPath.row].nameGroup
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupList?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.groupList?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passData(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        groupList?.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
}
