//
//  MemoryRealmObject.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 14/06/2021.
//

import RealmSwift
import Foundation

@objcMembers class MemoryRealmObject: Object {
    dynamic var id: String?
    dynamic var title: String?
    dynamic var memoryDescription: String?
    dynamic var imageData: Data?
    
    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(memory: Memory) {
        self.init()
        self.id = memory.id
        self.title = memory.title
        self.memoryDescription = memory.memoryDescription
        self.imageData = memory.imageData
    }
    
    func asMemory() -> Memory {
        let memory = Memory()
        memory.id = self.id
        memory.title = self.title
        memory.memoryDescription = self.memoryDescription
        memory.imageData = self.imageData
        return memory
    }
}
