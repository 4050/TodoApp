//
//  DetailViewController.swift
//  NoteAppSE
//
//  Created by Stanislav on 02.01.2022.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var nameTodo: String?
    var detalTask: String?
    @IBOutlet weak var textField: UITextField? {
        didSet {
            textField?.text = nameTodo
        }
    }
    @IBOutlet weak var detailTextView: UITextView? {
        didSet {
            detailTextView?.text = detalTask
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField?.addTarget(self, action: #selector(textFieldEditingDidChange), for: UIControl.Event.editingChanged)
    }
    
    func updateTask() {}
    
    @objc func textFieldEditingDidChange() {
        print("textfield changed")
    }
    
    func getData(nameTodo: String, detailTask: String) {
        self.nameTodo = nameTodo
        self.detalTask = detailTask
    }

}
