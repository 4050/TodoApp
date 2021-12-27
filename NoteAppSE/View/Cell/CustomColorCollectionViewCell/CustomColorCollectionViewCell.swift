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
    
    
  // func setupEmptyRadioButton() {
  //     radioButton.setBackgroundImage(UIImage(systemName: Image.circleFill), for: .normal)
  //     radioButton.tintColor = customColor
  // }
  //
  // func setupFullRadioButton() {
  //     radioButton.setBackgroundImage(UIImage(systemName: Image.checkmarkCircleFill), for: .normal)
  //     radioButton.tintColor = customColor
  // }
    
  // @IBAction func radioButtonTap(_ sender: UIButton) {
  //     delegate?.didTapButtonInCell(self)
  // }
    
}
