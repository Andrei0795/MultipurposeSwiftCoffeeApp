//
//  AboutViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import AVKit
import AVFoundation
import UIKit

class MemoryDetailsViewModel {
    var deleteBlock: (() -> Void)?
    var memory: Memory
    
    var title: String? {
        return memory.title
    }
    var description: String? {
        return memory.memoryDescription
    }
    
    var image: UIImage? {
        guard let imageData = memory.imageData else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    init(memory: Memory) {
        self.memory = memory
    }
    
    func delete() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let realmMemoryObject = appDelegate.appContext.realmManager.getMemoryObject(memory: memory) else {
            return
        }
        appDelegate.appContext.realmManager.deleteMemoryObject(object: realmMemoryObject)
        deleteBlock?()
    }
}
