//
//  CustomSwitcherTableViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 18.01.2022.
//

import UIKit

class CustomSwitcherTableViewCell: UITableViewCell {
    
    weak var vc: NewAddTaskTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func switchDetail(_ sender: UISwitch) {
        if sender.isOn {
            vc?.addCellTable()
        } else {
            vc?.deleteCellTable()
        }
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
