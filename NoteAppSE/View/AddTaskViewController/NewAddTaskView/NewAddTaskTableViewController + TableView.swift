//
//  NewAddTaskTableViewController + TableView.swift
//  NoteAppSE
//
//  Created by Stanislav on 30.01.2022.
//

import Foundation
import UIKit

extension NewAddTaskTableViewController  {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let nameSection = ["Название", "Цвет", "Подробности", nil]
        return nameSection[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let nameSection = ["Название", "Цвет", "Подробности", ""]
        return nameSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return rowInSection.count
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 3) {
            return CGFloat.leastNormalMagnitude
        }
        
        return tableView.sectionHeaderHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case IndexPath(row: 0, section: NewTaskSection.Name.rawValue):
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomTaskTableViewCell.identifier) as! CustomTaskTableViewCell
            cell.delegate = self
            return cell
        case IndexPath(row: 0, section: NewTaskSection.Color.rawValue):
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomColorTableViewCell.identifier) as! CustomColorTableViewCell
            cell.customCollectionView.dataSource = self
            cell.customCollectionView.delegate = self
            cell.customCollectionView.register(CustomColorCollectionViewCell.nib, forCellWithReuseIdentifier: CustomColorCollectionViewCell.identifier)
            return cell
        case IndexPath(row: 0, section: NewTaskSection.Switcher.rawValue):
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomSwitcherTableViewCell.identifier) as! CustomSwitcherTableViewCell
            cell.vc = self
            return cell
        case IndexPath(row: 0, section: NewTaskSection.Description.rawValue):
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomDetailTableViewCell.identifier) as! CustomDetailTableViewCell
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomTaskTableViewCell.identifier) as! CustomTaskTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case IndexPath(row: 0, section: NewTaskSection.Name.rawValue):
            return 44
        case IndexPath(row: 0, section: NewTaskSection.Color.rawValue):
            return 100
        case IndexPath(row: 0, section: NewTaskSection.Switcher.rawValue):
            return 50
        case IndexPath(row: 0, section: NewTaskSection.Description.rawValue):
            return 230
        default:
            return 100
        }
    }
}
