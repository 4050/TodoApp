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
       // setupEmptyRadioButton()
        super.awakeFromNib()
    }
    
    func setupEmptyRadioButton() {
        radioButton.layer.cornerRadius = 5
        radioButton.layer.borderWidth = 1
        radioButton.layer.borderColor = #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)
        radioButton.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func setupFullRadioButton() {
        radioButton.layer.cornerRadius = 5
        radioButton.layer.backgroundColor = #colorLiteral(red: 0.1710649792, green: 0.6276985593, blue: 1, alpha: 1)
        
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
