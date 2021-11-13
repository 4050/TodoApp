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
    
    var customColor: UIColor?
    
    var delegate: MyCellDelegate?
    var radioButtonTap: Bool = false

    override func awakeFromNib() {
       // setupEmptyRadioButton()
        super.awakeFromNib()
    }
    
    func setupEmptyRadioButton() {
        radioButton.layer.cornerRadius = 5
        radioButton.layer.borderWidth = 1
        radioButton.layer.borderColor = customColor?.cgColor
        radioButton.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func setupFullRadioButton() {
        radioButton.layer.cornerRadius = 5
        radioButton.layer.backgroundColor = customColor?.cgColor
        
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
