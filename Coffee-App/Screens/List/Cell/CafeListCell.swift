//
//  CafeListCell.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class CafeListCell: BaseTableViewCell {
    var cellViewModel: CafeListCellViewModel! {
        didSet {
            self.addSeparatorView()
            cafeTitle.text = cellViewModel.title
            cellViewModel.imageLoaded = { image in
                guard let theImage = image else {
                    return
                }
                self.cafeImage.image = theImage.image
            }
            if cellViewModel.image != nil {
                cafeImage.image = cellViewModel.image.image
            }
        }
    }
    @IBOutlet private var cafeImage: UIImageView!
    @IBOutlet private var cafeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        cafeImage.image = UIImage(named: "loadingImage")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cafeTitle.text = cellViewModel.title
        cafeImage.image = cellViewModel.image.image
    }
    
}
