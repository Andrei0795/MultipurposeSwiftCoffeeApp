//
//  CafeListCellViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class MemoryListCellViewModel {
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
    var memory: Memory

    init(memory: Memory) {
        self.memory = memory
    }
}

