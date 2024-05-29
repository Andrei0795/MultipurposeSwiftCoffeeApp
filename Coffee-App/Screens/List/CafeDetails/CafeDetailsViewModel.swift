//
//  CafeDetailsViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import SafariServices
import UIKit
import Social

class CafeDetailsViewModel {
    
    private var cafe: Cafe
    var imageLoaded: ((CustomImageView?) -> Void)?
    var favouriteChanged: (() -> Void)?

    var title: String? {
        return cafe.title
    }
    
    var isFavourite: Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.appContext.realmManager.getFavouriteObject(cafe: cafe) != nil
    }
    
    var description: String? {
        return cafe.cafeDescription
    }
    
    var image: UIImage? {
        guard let data = cafe.image else {
            return nil
        }
        return UIImage(data: data)
    }
    
    var imageView: CustomImageView!
    
    init(cafe: Cafe) {
        self.cafe = cafe
    }
    
    func downloadImage() {
        imageView = CustomImageView.init(image: UIImage(named: "loadingImage"), highlightedImage: nil)
        
        imageView.imageLoaded = {
            self.imageLoaded?(self.imageView)
        }
        if let imageLink = cafe.imageLink {
            imageView.downloaded(from: imageLink)
        }
    }
    
    func tappedShareButton(navigationController: UINavigationController, view: UIView) {
        guard let title = cafe.title else {
            return
        }
        let text = "Check out this cool new cafe in Bucharest: " + title
        let image = UIImage(named: "cafeStandardImage")
        let shareAll = [text , image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        navigationController.present(activityViewController, animated: true, completion: nil)
    }
    
    func tappedAddToFavourites() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        cafe.isFavourite = !cafe.isFavourite
        
        if let favourite =  appDelegate.appContext.realmManager.getFavouriteObject(cafe: cafe) {
            appDelegate.appContext.realmManager.deleteFavouriteObject(object: favourite)
        } else {
            let favourite = FavouriteRealmObject(cafe: cafe)
            appDelegate.appContext.realmManager.saveFavouriteObject(object: favourite)
        }
    }
    
    func tappedRemind() {
        let manager = LocalNotificationManager()
        guard let cafeID = cafe.id, let cafeName = cafe.title else {
            return
        }
        let notificationID = "reminder" + cafeID
        let notificationTitle = "Buy coffee today from " + cafeName
        
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day!, hour: now.hour!, minute: now.minute! + 1)
        
        //let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1, hour: 8, minute: 0)

    
        manager.notifications = [
            Notification(id: notificationID, title: notificationTitle, datetime: tomorrow)
        ]

        manager.schedule()
    }
    
    func tappedShowWebsite(navigationController: UINavigationController) {
        if let websiteLink = cafe.websiteLink, !websiteLink.isEmpty, let url = URL(string: websiteLink) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            navigationController.present(vc, animated: true, completion: nil)
        }
    }
    
    func tappedPhone() {
        
    }
    
    func tappedDismiss() {
        
    }
}
