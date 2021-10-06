//
//  NewCafesCellViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class NewCafesCellViewModel: HomeCollectionCellViewModelProtocol {
    var cafeID: String
    var title: String
    var imageString: String?
    private var image: CustomImageView!
    var imageLoaded: ((CustomImageView?) -> Void)?

    init(cafeID: String, title: String, imageLink: String?) {
        self.cafeID = cafeID
        self.title = title
        self.imageString = imageLink
        self.image = CustomImageView.init(image: UIImage(named: "loadingImage"), highlightedImage: nil)
        self.image.imageLoaded = {
            self.imageLoaded?(self.image)
        }
        if let imageLink = imageLink {
            self.image.downloaded(from: imageLink)
        }
    }
}
