//
//  HomeCollectionView.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class HomeCollectionView: UICollectionView {
    var collectionViewModel: HomeCollectionViewModel! {
        didSet {
            reloadData()
            configureCollectionViewCellSize()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configureCollectionViewCellSize() {
        if let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            switch collectionViewModel.type {
            case .newCafes:
                flowLayout.itemSize = CGSize(width: 211, height: 128)
            case .actions:
                flowLayout.itemSize = CGSize(width: 138, height: 128)
            default:
                flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }
            
            flowLayout.invalidateLayout()
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
        }
    }
    
    private func configure() {
        HomeActionCell.register(to: self)
        NewCafesCell.register(to: self)

        self.showsHorizontalScrollIndicator = false
        self.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.delegate = self
        self.dataSource = self
    }
}

extension HomeCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionViewModel.type == .actions {
            let cellID = HomeActionCell.identifier
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? HomeActionCell else {
                assertionFailure("Unable to dequeue cell")
                return UICollectionViewCell()
            }
            cell.cellViewModel = collectionViewModel.cellViewModel(at: indexPath) as? HomeActionCellViewModel
            return cell
            
        } else {
            let cellID = NewCafesCell.identifier
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? NewCafesCell else {
                assertionFailure("Unable to dequeue cell")
                return UICollectionViewCell()
            }
            cell.cellViewModel = collectionViewModel.cellViewModel(at: indexPath) as? NewCafesCellViewModel
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionViewModel.didSelectItem(at: indexPath)
    }
}
