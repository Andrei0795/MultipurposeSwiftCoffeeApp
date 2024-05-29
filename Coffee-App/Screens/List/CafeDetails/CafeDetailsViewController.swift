//
//  CafeDetailsViewController.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class CafeDetailsViewController: UIViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var starButton: UIButton!
    @IBOutlet private var textView: UITextView!
    
    var viewModel: CafeDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        titleLabel.text = viewModel.title
        textView.text = viewModel.description
        imageView.layer.cornerRadius = 8.0
        title = "Cafe Details"
        
        let buttonImageName = viewModel.isFavourite ? "fullStar" : "emptyStar"
        starButton.setImage(UIImage(named: buttonImageName), for: .normal)
        if let image = viewModel.image {
            imageView.image = image
        } else {
            viewModel.imageLoaded = { theImageView in
                self.imageView.image = theImageView?.image
            }
            viewModel.downloadImage()
        }
    }
    
    @IBAction func tappedWebsite(_ sender: Any) {
        guard let navigationController = navigationController else {
            return
        }
        viewModel.tappedShowWebsite(navigationController: navigationController)
    }
    
    @IBAction func tappedStar(_ sender: Any) {
        viewModel.tappedAddToFavourites()
        let buttonImageName = viewModel.isFavourite ? "fullStar" : "emptyStar"
        starButton.setImage(UIImage(named: buttonImageName), for: .normal)
    }
    
    @IBAction func tappedremind(_ sender: Any) {
        viewModel.tappedRemind()
    }
    
    @IBAction func tappedShare(_ sender: Any) {
        guard let navigationController = navigationController else {
            return
        }
        
        viewModel.tappedShareButton(navigationController: navigationController, view: view)
    }
}
