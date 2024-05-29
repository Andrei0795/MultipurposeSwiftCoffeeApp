//
//  NewCafesCell.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class NewCafesCell: UICollectionViewCell {
    @IBOutlet private var cafeTitle: UILabel!
    @IBOutlet private var cafeImage: CustomImageView!
    
    var cellViewModel: NewCafesCellViewModel! {
        didSet {
            cafeTitle.text = cellViewModel.title
            cellViewModel.imageLoaded = { image in
                guard let theImage = image else {
                    return
                }
                self.cafeImage.image = theImage.image
            }
            cellViewModel.getImage()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        cafeImage.layer.cornerRadius = 8.0
        cafeImage.image = UIImage(named: "loadingImage")
    }
}
