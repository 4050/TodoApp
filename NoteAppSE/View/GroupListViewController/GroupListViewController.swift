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
    
    //  @IBOutlet weak var dateButton: UIButton! {
    //      didSet {
    //          let currentDate = setupCurrentDate()
    //          self.dateButton.setTitle(currentDate, for: .normal)
    //      }
    //  }
    
    
    private var groupList: [GroupListModel]?
    private var groupListCollectionView = GroupListCollectionView()
    private var dateService = DateService()
    
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
        //navButton()
        setupNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupListCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        groupListCollectionView.reloadData()
    }
    
   // func navButton() {
   //     let image = UIImage(systemName: Image.gearshape)
   //     self.navigationItem.rightBarButtonItem = self.editButtonItem
   //     self.navigationItem.rightBarButtonItem?.primaryAction = UIAction(image: image) { _ in
   //         self.setEditing(!self.isEditing, animated: true)
   //     }
   // }
   //
   // override func setEditing(_ editing: Bool, animated: Bool) {
   //     super.setEditing(editing, animated:animated)
   //     self.groupListCollectionView.isEditing = editing
   // }
    
    
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
                     GroupListModel(nameGroup: "Gym", numberTasks: "5", colorCell: nil, taskList: [TaskModel(taskName: "Bench Press"),
                                                                                                   TaskModel(taskName: "Bench Press"),
                                                                                                   TaskModel(taskName: "Bench Press"), TaskModel(taskName: "Bench Press"), TaskModel(taskName: "Bench Press")]),
                     GroupListModel(nameGroup: "Shop", numberTasks: "2", colorCell: nil),
                     GroupListModel(nameGroup: "Work", numberTasks: "11", colorCell: nil)]
        groupListCollectionView.setupValue(groupList: groupList)
    }
    
    func passData(index: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "TodoListTableViewController") as? TodoListTableViewController else { return }
        vc.groupList = groupList![index]
        vc.taskList = groupList![index].taskList
        navigationController?.pushViewController(vc, animated: true)
        
    }
}



