//
//  CustomCollectionViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 24.05.2021.
//

import UIKit

class CustomCollectionViewCell: UITableViewCell {
    
    @IBOutlet weak var sheetNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private(set) var cellColor: UIColor = .white

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    class var identifier: String {
        return String(describing: self)
    }

    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
