//
//  CustomTableViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 01.07.2021.
//

import UIKit

protocol MyCellDelegate {
    func didTapButtonInCell(_ cell: CustomTableViewCell)
    func didTextFieldShouldBeginEditing(_ cell: CustomTableViewCell)
    func didTextFieldShouldEndEditing(_ cell: CustomTableViewCell)
   }

class CustomTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var radioButton: UIButton!
    var customColor: UIColor?
    
    var delegate: MyCellDelegate?

    override func awakeFromNib() {
        taskName.addTarget(self, action: #selector(didTextFieldShouldBeginEditing), for: .editingDidBegin)
        taskName.addTarget(self, action: #selector(didTextFieldShouldEndEditing), for: .editingDidEnd)
        taskName.delegate = self
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
    
    func setupEmptyRadioButton() {
        radioButton.setBackgroundImage(UIImage(systemName: Image.circle), for: .normal)
        radioButton.tintColor = customColor
    }
    
    func setupFullRadioButton() {
        radioButton.setBackgroundImage(UIImage(systemName: Image.checkmarkCircleFill), for: .normal)
        radioButton.tintColor = customColor
    }
    
    @objc func didTextFieldShouldBeginEditing() {
        delegate?.didTextFieldShouldBeginEditing(self)
    }
    
    @objc func didTextFieldShouldEndEditing() {
        delegate?.didTextFieldShouldEndEditing(self)
    }
    
    @IBAction func radioButtonTap(_ sender: UIButton) {
        delegate?.didTapButtonInCell(self)
    }
}
