//
//  GroupListCollectionView.swift
//  NoteAppSE
//
//  Created by Stanislav on 29.05.2021.
//

import UIKit

class GroupListCollectionView: UICollectionView {
    
    let itemsPerRow: CGFloat = 2
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    private var groupList: [GroupListModel]?
    weak var delegatePassData: GroupListViewControllerProtocol?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        delegate = self
        dataSource = self
        register(CustomCollectionViewCell.nib, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        let config = UICollectionLayoutListConfiguration(appearance:
                                                            .insetGrouped)
        collectionViewLayout =
          UICollectionViewCompositionalLayout.list(using: config)
    }
    
    func setupValue(groupList: [GroupListModel]?) {
        self.groupList = groupList
    }
}

extension GroupListCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.sheetNameLabel.text = groupList![indexPath.row].nameGroup
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        delegatePassData?.passData(index: indexPath.row)
    }
    
}
