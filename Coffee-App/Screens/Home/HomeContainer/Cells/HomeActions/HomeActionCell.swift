//
//  CafeListCell.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class HomeActionCell: UICollectionViewCell {
    @IBOutlet private var actionTitle: UILabel!
    @IBOutlet private var actionImage: UIImageView!
    
    var cellViewModel: HomeActionCellViewModel! {
        didSet {
            actionTitle.text = cellViewModel.title
            actionImage.image = UIImage(named: cellViewModel.imageString)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
