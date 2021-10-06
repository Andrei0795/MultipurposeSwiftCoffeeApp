//
//  AboutViewController.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import AVKit
import AVFoundation
import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet private var playerView: UIView!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var cancelButton: UIButton!

    var viewModel: AboutViewModel!
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.isEditable = false
        
        let videoURL = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        self.player = AVPlayer(url: videoURL!)
        self.playerViewController = AVPlayerViewController()
        playerViewController.player = self.player
        playerViewController.view.frame = self.playerView.frame
        playerViewController.player?.pause()
        self.playerView.addSubview(playerViewController.view)
        
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: playerViewController.view!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: playerView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: playerViewController.view!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: playerView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: playerViewController.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: playerView.frame.width)
        let heightConstraint = NSLayoutConstraint(item: playerViewController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: playerView.frame.height)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tappedCancelButton(_sender: Any) {
        viewModel.dismiss()
    }
}
