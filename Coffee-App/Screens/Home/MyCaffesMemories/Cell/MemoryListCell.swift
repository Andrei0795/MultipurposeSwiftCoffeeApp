//
//  MemoryListCell.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class MemoryListCell: BaseTableViewCell {
    var cellViewModel: MemoryListCellViewModel! {
        didSet {
            self.addSeparatorView()
            cafeTitle.text = cellViewModel.title
            cafeImage.image = cellViewModel.image
        }
    }
    @IBOutlet private var cafeImage: UIImageView!
    @IBOutlet private var cafeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cafeTitle.text = cellViewModel.title
        cafeImage.image = cellViewModel.image
    }
    
}
