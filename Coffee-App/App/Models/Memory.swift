//
//  Memory.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 16/06/2021.
//

import Foundation

class Memory {
    var id: String?
    var title: String?
    var memoryDescription: String?
    var imageData: Data?
    
    convenience init(id: String?, title: String?, memoryDescription: String?, imageData: Data?) {
        self.init()
        self.id = id
        self.title = title
        self.memoryDescription = memoryDescription
        self.imageData = imageData
    }
}
