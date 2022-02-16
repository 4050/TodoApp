//
//  AddGroupViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 24.10.2021.
//

import UIKit

class AddGroupViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionColorView: UICollectionView!
    @IBOutlet weak var colorTableCell: UITableViewCell!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var colorView: UIView!
    
    var cellDelegate: CustomColorCollectionViewCellDelegate?

    var selectColor: String?
    var checkmarkIndex: Int?
    var taskGroupsListTableViewController: TaskGroupsListViewController?
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var colors: [UIColor] = [UIColor.systemGreen, UIColor.systemRed, UIColor.systemBlue, UIColor.systemYellow, UIColor.systemOrange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
        setupNavigationBar()
        self.collectionColorView.dataSource = self
        self.collectionColorView.delegate = self
        let cellNib = UINib(nibName: "CustomColorCollectionViewCell", bundle: nil)
        self.collectionColorView.register(cellNib, forCellWithReuseIdentifier: "CustomColorCollectionViewCell")
    }
    
    
    
    func setupNavigationBar() {
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
    
    @objc func addTapped() {
        let nameGroup: String = textField.text ?? "Empty"
        let groupModel = CategoryModel(nameCategory: nameGroup, numberTasks: nil, colorCategory: selectColor)
        taskGroupsListTableViewController?.addGroupToGroupList(category: groupModel)
        dismiss(animated: true, completion: nil)
    }

}

extension AddGroupViewController: CustomColorCollectionViewCellDelegate {
    
    func collectionView(collectionviewcell: CustomColorCollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomColorCollectionViewCell", for: indexPath) as! CustomColorCollectionViewCell
        cell.delegate = self
        cell.customColor = colors[indexPath.row]
        if !cell.checkmark {
            cell.setupEmptyImageView()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CustomColorCollectionViewCell
        cell?.setupFullImageView()
        selectColor = colors[indexPath.row].toHexString()
        print(colors[indexPath.row])
        cell?.checkmark = true
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CustomColorCollectionViewCell
        cell?.setupEmptyImageView()
        cell?.checkmark = false
    }
}
