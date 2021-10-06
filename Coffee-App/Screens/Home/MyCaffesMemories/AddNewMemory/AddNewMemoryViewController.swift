//
//  AddNewMemoryViewController.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 16/06/2021.
//

import UIKit
import NotificationCenter

class AddNewMemoryViewController: UIViewController {
    @IBOutlet private var addButton: UIButton!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var theView: UIView!
    @IBOutlet private var addImageLabel: UILabel!
    @IBOutlet private var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var imageWidthConstraint: NSLayoutConstraint!

    var viewModel: AddNewMemoryViewModel!
    
    @IBAction func tappedImage(_ sender: UIButton) {
        viewModel.tappedImage(sender)
    }
    
    @IBAction func tappedSave(_ sender: Any) {
        viewModel.textFieldText = textField.text
        viewModel.textViewText = textView.text
        viewModel.tappedSave()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        viewModel.addedImage = { image in
            self.addButton.setImage(image, for: .normal)
            self.theView.alpha = 1
            self.theView.backgroundColor = .white
            self.addImageLabel.isHidden = true
            self.imageWidthConstraint.constant = 244
            self.imageHeightConstraint.constant = 144
        }
        textField.placeholder = "Enter title here"
        textView.text = "Enter description here"
        textView.delegate = self
        textField.delegate = self
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}

extension AddNewMemoryViewController: UITextViewDelegate, UITextFieldDelegate {
    
}

