//
//  CustomCollectionViewCell.swift
//  NoteAppSE
//
//  Created by Stanislav on 24.05.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewListCell {
    
    var sheetNameLabel = UILabel()
    var descriptionLabel = UILabel()
    
    private(set) var cellColor: UIColor = .white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
  //  class var nib: UINib {
  //      return UINib(nibName: identifier, bundle: nil)
  //  }
    
    
    enum Constants {
        static let padding: CGFloat = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    private func setupViews() {
        sheetNameLabel.numberOfLines = 0
        sheetNameLabel.adjustsFontForContentSizeCategory = true
        sheetNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sheetNameLabel)
        
       //descriptionLabel.numberOfLines = 0
       //descriptionLabel.adjustsFontForContentSizeCategory = true
       //descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
       //addSubview(descriptionLabel)
        
       // let imageView = UIImageView(frame: .zero)
       // imageView.image = UIImage(named: "person")
       // imageView.translatesAutoresizingMaskIntoConstraints = false
       // addSubview(imageView)
        
        NSLayoutConstraint.activate([
            //imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            sheetNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 20),
            sheetNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            sheetNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            sheetNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding),
            separatorLayoutGuide.leadingAnchor.constraint(equalTo: sheetNameLabel.leadingAnchor),
            
           // descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
           // descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
           // descriptionLabel.topAnchor.constraint(equalTo: sheetNameLabel.topAnchor, constant: Constants.padding),
           // descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding),
            
           //imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
           //imageView.heightAnchor.constraint(equalToConstant: 30),
           //imageView.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
