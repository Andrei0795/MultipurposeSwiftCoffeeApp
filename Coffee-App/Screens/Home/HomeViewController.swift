//
//  HomeViewController.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private var newCafesCollectionView: HomeCollectionView!
    @IBOutlet private var actionsCollectionView: HomeCollectionView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var cupImage: UIImageView!
    @IBOutlet private var smokeImage: UIImageView!
    @IBOutlet private var newsView: UIView!
    @IBOutlet private var newsTitleLabel: UILabel!
    @IBOutlet private var newsDescriptionLabel: UILabel!

    var viewModel: HomeViewModel!
    var countdown = 200
    var myTimer: Timer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        viewModel = HomeViewModel()
        viewModel.delegate = self
        configureCollectionViews()
        activityIndicator.startAnimating()
        newCafesCollectionView.isHidden = true
        actionsCollectionView.isHidden = true
        view.isUserInteractionEnabled = false
        smokeImage.alpha = 0.0
        newsView.alpha = 0.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(shakeCup))
        cupImage.addGestureRecognizer(tap)
        cupImage.isUserInteractionEnabled = true
        
        viewModel.loadCafeData()
        viewModel.loadNewsData()
    }
    
    private func configureCollectionViews() {
        guard let navigationController = navigationController else {
            return
        }
        newCafesCollectionView.collectionViewModel = NewCafesCollectionViewModel(type: .newCafes, navigationController: navigationController, newCafes: [Cafe]())

        actionsCollectionView.collectionViewModel = ActionsCollectionViewModel(type: .actions, navigationController: navigationController)

    }
    
    @objc private func shakeCup() {
        shakeView(view: cupImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            self.smokeImage.alpha = 0.5
        }
        positionView(view: smokeImage)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.smokeImage.alpha = 0.0
        }
    }
    
    func shakeView(view: UIView) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, -5, 5, -5, 0 ]
        animation.keyTimes = [0, 0.125, 0.25, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 0.5
        animation.isAdditive = true

        view.layer.add(animation, forKey: "shake")
    }
    
    func positionView(view: UIView) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.y"
        animation.values = [0, 10, -10, -5, 5, 0 ]
        animation.keyTimes = [0, 0.125, 0.25, 0.5, 0.625, 0.75, 1]
        animation.duration = 2
        
        animation.isAdditive = true

        view.layer.add(animation, forKey: "position")
    }
    
    @objc func countDownTick() {
        countdown -= 1
        
        if countdown % 10 == 0 {
            let newsItem = viewModel.getNewsItem()
            
            DispatchQueue.main.async{
                self.newsTitleLabel.text = newsItem.title
                self.newsDescriptionLabel.text = newsItem.description
            }
        }

        if countdown == 0 {
           myTimer!.invalidate()
           myTimer = nil
        }
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    func homeViewModelDidLoadNewCafes(viewModel: HomeViewModel, newCafes: [Cafe]) {
        guard let navigationController = navigationController else {
            return
        }
        
        newCafesCollectionView.collectionViewModel = NewCafesCollectionViewModel(type: .newCafes, navigationController: navigationController, newCafes: newCafes)
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        newCafesCollectionView.isHidden = false
        actionsCollectionView.isHidden = false
        view.isUserInteractionEnabled = true
        shakeCup()
        newsView.alpha = 1.0
    }
    
    func homeViewModelDidLoadNews(viewModel: HomeViewModel) {
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownTick), userInfo: nil, repeats: true)
        let newsItem = viewModel.getNewsItem()
        newsTitleLabel.text = newsItem.title
        newsDescriptionLabel.text = newsItem.description
    }
}


