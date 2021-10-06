//
//  MemoryDetailsViewController.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class MemoryDetailsViewController: UIViewController {
    
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var deleteButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!

    var viewModel: MemoryDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        titleLabel.text = viewModel.title
        textView.text = viewModel.description
        imageView.image = viewModel.image
    }

    
    @IBAction func tappedDelete(_sender: Any) {
        viewModel.delete()
    }
}
