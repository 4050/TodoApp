//
//  CustomCollectionViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 24.05.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewListCell {
    
   // var sheetNameLabel = UILabel()
   // var descriptionLabel = UILabel()
    
    
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
    
    
    enum Constants {
        static let padding: CGFloat = 10
    }
    
    
//    private func setupViews() {
//       // sheetNameLabel.numberOfLines = 0
//       // sheetNameLabel.adjustsFontForContentSizeCategory = true
//       // sheetNameLabel.translatesAutoresizingMaskIntoConstraints = false
//       // addSubview(sheetNameLabel)
//
//       // descriptionLabel.numberOfLines = 0
//       // descriptionLabel.adjustsFontForContentSizeCategory = true
//       // descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//       // addSubview(descriptionLabel)
//
//       // let imageView = UIImageView(frame: .zero)
//       // imageView.image = UIImage(named: "person")
//       // imageView.translatesAutoresizingMaskIntoConstraints = false
//       // addSubview(imageView)
//
//        NSLayoutConstraint.activate([
//            //imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
//            sheetNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 20),
//            sheetNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            sheetNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            sheetNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
//            //separatorLayoutGuide.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
//
//            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
//            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
//
//           //imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
//           //imageView.heightAnchor.constraint(equalToConstant: 30),
//           //imageView.widthAnchor.constraint(equalToConstant: 30),
//        ])
//    }

    
}
