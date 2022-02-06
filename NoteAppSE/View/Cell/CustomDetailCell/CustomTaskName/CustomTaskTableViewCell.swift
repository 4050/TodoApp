//
//  CustomTaskTableViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 18.01.2022.
//

import UIKit

protocol CustomTaskTableViewCellDelegate {
    func getNameTask(cell: CustomTaskTableViewCell)
}

class CustomTaskTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    var delegate: CustomTaskTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.addTarget(self, action: #selector(didTextFieldShouldEndEditing), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
   @objc func didTextFieldShouldEndEditing() {
        delegate?.getNameTask(cell: self)
    }
}
