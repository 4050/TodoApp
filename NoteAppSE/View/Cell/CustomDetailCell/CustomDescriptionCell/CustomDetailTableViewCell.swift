//
//  CustomDetailTableViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 07.01.2022.
//

import UIKit

protocol CustomDetailTableViewCellDelegate {
    func getDescriptionTask(cell: CustomDetailTableViewCell)
}

class CustomDetailTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!

    var delegate: CustomDetailTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
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
    
    func textViewDidChange(_ textView: UITextView) {
        delegate?.getDescriptionTask(cell: self)
       }
}
