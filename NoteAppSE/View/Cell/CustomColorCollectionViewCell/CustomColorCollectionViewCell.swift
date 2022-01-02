//
//  CustomColorCollectionViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 26.12.2021.
//

import UIKit

protocol CustomColorCollectionViewCellDelegate {
    func collectionView(collectionviewcell: CustomColorCollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell)
}

class CustomColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var checkmark: Bool = false
    var customColor: UIColor?
    var delegate: CustomColorCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupEmptyImageView()
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setupEmptyImageView() {
        imageView.image = UIImage(systemName: Image.circleFill)
        imageView.tintColor = customColor
    }
    
    func setupFullImageView() {
        imageView.image = UIImage(systemName: Image.checkmarkCircleFill)
        imageView.tintColor = customColor
    }
}
