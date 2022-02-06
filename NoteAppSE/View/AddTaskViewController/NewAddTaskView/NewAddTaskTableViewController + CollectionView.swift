//
//  NewAddTaskViewController + CollectionView.swift
//  NoteAppSE
//
//  Created by Stanislav on 30.01.2022.
//

import Foundation
import UIKit

extension NewAddTaskTableViewController: CustomColorCollectionViewCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionviewcell: CustomColorCollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell){}
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomColorCollectionViewCell", for: indexPath) as! CustomColorCollectionViewCell
        cell.delegate = self
        cell.customColor = colors[indexPath.row]
        if !cell.checkmark {
            cell.setupEmptyImageView()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CustomColorCollectionViewCell
        cell?.setupFullImageView()
        selectColor = colors[indexPath.row].toHexString()
        cell?.checkmark = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CustomColorCollectionViewCell
        cell?.setupEmptyImageView()
        cell?.checkmark = false
    }
}
