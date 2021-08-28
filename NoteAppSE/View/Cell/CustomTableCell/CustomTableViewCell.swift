//
//  CustomTableViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 01.07.2021.
//

import UIKit

protocol MyCellDelegate {
       func didTapButtonInCell(_ cell: CustomTableViewCell)
   }

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var radioButton: UIButton!
    
    var delegate: MyCellDelegate?
    var radioButtonTap: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    @IBAction func radioButtonTap(_ sender: UIButton) {
        delegate?.didTapButtonInCell(self)
    }
}
