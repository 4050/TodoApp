//
//  ViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 24.05.2021.
//

import UIKit

protocol GroupListViewControllerProtocol: AnyObject {
    func passData(index: Int)
}

class GroupListViewController: UIViewController, GroupListViewControllerProtocol {
    
    private var groupList: [GroupListModel]?
    public var groupListCollectionView = GroupListCollectionView()
    private var dateService = DateService()
    private var colorTheme = Colors.defaultColor
    
    private let addButton: UIButton = {
        let button = UIButton()
        if #available(iOS 15.0, *) {
            button.setTitle("Новый список", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
            button.configuration = .filled()
            button.configuration?.baseBackgroundColor = UIColor.systemBlue
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
        } else {
            button.setTitle("Новый список", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
            button.layer.backgroundColor = UIColor.systemBlue.cgColor
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupListCollectionView.delegatePassData = self
        view.addSubview(groupListCollectionView)
        groupListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        groupListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        groupListCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        groupListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        setupValueCell()
        groupListCollectionView.backgroundColor = .blue.withAlphaComponent(0.2)
        
        setupNavigationBar()
        view.addSubview(addButton)
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupListCollectionView.reloadData()
    }
    
   // override func viewDidAppear(_ animated: Bool) {
   //     super.viewDidAppear(animated)
   //     groupListCollectionView.reloadData()
   // }
    
    @objc func tapAddButton() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddGroupViewController") as! AddGroupViewController
        let navigationController = UINavigationController(rootViewController: vc)
        vc.groupListViewController = self
        navigationController.modalPresentationStyle = .automatic
        present(navigationController, animated: true)
    }
    
    func setupNavigationBar() {
        let currentDate = setupCurrentDate()
        title = currentDate
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
    }
    
    func setupCurrentDate() -> String {
        return dateService.getCurrentDate()
    }
    
    func setupValueCell() {
        groupList = [GroupListModel(nameGroup: "HomeTODO", numberTasks: "10", colorCell: nil),
                     GroupListModel(nameGroup: "Gym", numberTasks: "5", colorCell: nil, taskList: [TaskModel(taskName: "Bench Press", colorCell: "#9992ff", completedTask: false),
                                                                                                   TaskModel(taskName: "Bench Press", colorCell: "#9992ff"),
                                                                                                   TaskModel(taskName: "Bench Press", colorCell: "#9992ff"),
                                                                                                   TaskModel(taskName: "Bench Press", colorCell: "#9992ff"),
                                                                                                   TaskModel(taskName: "Bench Press", colorCell: "#9992ff"),
                                                                                                  ]),
                     GroupListModel(nameGroup: "Shop", numberTasks: "2", colorCell: nil, taskList: [TaskModel(taskName: "Milk", colorCell: "#9992ff", completedTask: false)]),
                     GroupListModel(nameGroup: "Work", numberTasks: "11", colorCell: nil, taskList: []),
                     GroupListModel(nameGroup: "Работа", numberTasks: "11", colorCell: nil, taskList: []),
                     GroupListModel(nameGroup: "HomeTODO", numberTasks: nil, colorCell: nil, taskList: []),
                     GroupListModel(nameGroup: "`12`", numberTasks: nil, colorCell: nil, taskList: [])
        ]
        groupListCollectionView.setupValue(groupList: groupList)
    }
    
    func addGroupToGroupList(group: GroupListModel) {
        groupList?.append(group)
        groupListCollectionView.setupValue(groupList: groupList)
        groupListCollectionView.reloadData()
    }
    
    func passData(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "TodoListTableViewController") as? TodoListTableViewController else { return }
        vc.groupList = groupList![index]
        vc.taskList = groupList![index].taskList
        navigationController?.pushViewController(vc, animated: true)
    }
}



