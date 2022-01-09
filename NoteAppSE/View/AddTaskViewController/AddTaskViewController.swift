//
//  AddTaskViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 19.09.2021.
//

import UIKit

class AddTaskViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionColorView: UICollectionView!
    @IBOutlet weak var colorTableCell: UITableViewCell!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailSwitcher: UISwitch!
    @IBOutlet weak var detailViewCell: UITableViewCell!
    
    var cellDelegate: CustomColorCollectionViewCellDelegate?
    
    var colors: [UIColor] = [UIColor.systemGreen, UIColor.systemRed, UIColor.systemBlue, UIColor.systemYellow, UIColor.systemOrange]
    
    var selectColor: String?
    var selectedCategory: Group?
    var todoListTableViewController: TodoListTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewCell()
        setupNavigationBar()
        self.detailViewCell.isHidden = true
        
    }
    
    func setupCollectionViewCell() {
        let cellNib = UINib(nibName: "CustomColorCollectionViewCell", bundle: nil)
        self.collectionColorView.dataSource = self
        self.collectionColorView.delegate = self
        self.collectionColorView.register(cellNib, forCellWithReuseIdentifier: "CustomColorCollectionViewCell")
    }
    
    @IBAction func switchCell(_ sender: UISwitch) {
        if sender.isOn {
            sender.isOn = true
            UIView.animate(
              withDuration: 1.5,
              delay: 1,
              usingSpringWithDamping: 0.7,
              initialSpringVelocity: 0.8,
              options: UIView.AnimationOptions.curveEaseInOut,
              animations: {
                  self.detailViewCell.isHidden = false
                
            }, completion: nil)
        } else {
            sender.isOn = false
            UIView.animate(
              withDuration: 1.5,
              delay: 1,
              usingSpringWithDamping: 0.7,
              initialSpringVelocity: 0.8,
              options: UIView.AnimationOptions.curveEaseInOut,
              animations: {
                  self.detailViewCell.isHidden = true
            }, completion: nil)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(hex: Colors.darkColor).cgColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(hex: Colors.darkColor).cgColor]
        
        title = "Новая задача"
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
        let task: String = textField.text ?? "Empty"
        let color: String = selectColor ?? UIColor.systemBlue.toHexString()
        let taskModel = TaskModel(taskName: task, colorCell: color, completedTask: false)
        todoListTableViewController?.addTaskToTaskList(taskModel: taskModel)
        dismiss(animated: true, completion: nil)
    }
}

extension AddTaskViewController: CustomColorCollectionViewCellDelegate {
    
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
        cell?.checkmark = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CustomColorCollectionViewCell
        cell?.setupEmptyImageView()
        cell?.checkmark = false
    }
}
