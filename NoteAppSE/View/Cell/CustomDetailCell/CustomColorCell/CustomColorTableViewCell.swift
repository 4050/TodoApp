//
//  CustomColorTableViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 18.01.2022.
//

import UIKit

class CustomColorTableViewCell: UITableViewCell {
    

    @IBOutlet weak var customCollectionView: UICollectionView!
    
    weak var vc: NewAddTaskTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {}

    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
