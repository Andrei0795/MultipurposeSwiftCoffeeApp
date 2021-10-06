//
//  AboutViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import AVKit
import AVFoundation
import UIKit

class AboutViewModel {
    var dismissBlock: (() -> Void)?
    func dismiss() {
        dismissBlock?()
    }
}
