//
//  AddNewMemoryViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 16/06/2021.
//

import UIKit


class AddNewMemoryViewModel {
    
    var image: UIImage?
    var imagePicker: ImagePicker!
    var addedImage: ((UIImage?) -> Void)?
    var textFieldText: String?
    var textViewText: String?
    var dismissBlock: (() -> Void)?

    init() {
        
    }
    
    func tappedImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender as UIView)
    }
    
    func tappedSave() {
        guard let textfieldText = textFieldText, let textViewText = textViewText, let image = image?.jpegData(compressionQuality: 1), !textViewText.isEmpty, textViewText != "Enter description here" else {
            print("Should not be empty")
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        

        let uniqueID = String(Date().timeIntervalSince1970)
        let memory = Memory(id: uniqueID, title: textfieldText, memoryDescription: textViewText, imageData: image)
        let memoryRealmObject = MemoryRealmObject(memory: memory)
        appDelegate.appContext.realmManager.saveMemoryObject(object: memoryRealmObject)
        dismissBlock?()
    }
}

extension AddNewMemoryViewModel: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.image = image
        addedImage?(image)
    }
}
