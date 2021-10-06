//
//  CafeListCellViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class CafeListCellViewModel {
    var cafeID: String
    var title: String
    var imageLink: String?
    var image: CustomImageView!
    var imageLoaded: ((CustomImageView?) -> Void)?
    var cafe: Cafe

    init(cafeID: String, title: String, imageLink: String?, cafe: Cafe) {
        self.cafeID = cafeID
        self.cafe = cafe
        self.title = title
        self.imageLink = imageLink
        
        if let cafeImageData = cafe.image {
            let theImage = UIImage(data: cafeImageData)
            image = CustomImageView.init(image: theImage, highlightedImage: nil)
            imageLoaded?(self.image)
        } else {
            self.image = CustomImageView.init(image: UIImage(named: "loadingImage"), highlightedImage: nil)
            self.image.imageLoaded = {
                cafe.image = self.image.image?.jpegData(compressionQuality: 1)
                self.imageLoaded?(self.image)
            }
            if let imageLink = imageLink {
                self.image.downloaded(from: imageLink)
            }
        }
    }
}
