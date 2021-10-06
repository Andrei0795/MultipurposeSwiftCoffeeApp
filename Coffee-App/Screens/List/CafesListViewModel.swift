//
//  CafesListViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class CafesListViewModel {
    
    private var cafesDatasource = [CafeListCellViewModel]()
    private var appDelegate: AppDelegate!
    var dismissBlock: (() -> Void)?
    var isFavouriteList: Bool = false
    
    init(isFavouriteList: Bool = false) {
        self.isFavouriteList = isFavouriteList
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        if isFavouriteList {
            guard let realmFavourites = appDelegate.appContext.realmManager.getFavouriteObjects() else {
                return
            }
            var favourites = [Cafe]()
            for realmFavourite in realmFavourites {
                favourites.append(realmFavourite.asCafe())
            }
            setupDatasource(cafes: favourites)
        } else {
            setupDatasource(cafes: appDelegate.appContext.cafesDatasource)
        }
    }
    
    private func setupDatasource(cafes: [Cafe]) {
        for cafe in cafes {
            if let id = cafe.id, let title = cafe.title {
                let cellViewModel = CafeListCellViewModel(cafeID: id, title: title, imageLink: cafe.imageLink, cafe: cafe)
                cafesDatasource.append(cellViewModel)
            }
        }
    }
    
    func dismiss() {
        dismissBlock?()
    }
    
    func numberOfRows() -> Int {
        return cafesDatasource.count
    }
    
    func cellViewModelAt(indexPath: IndexPath) -> CafeListCellViewModel {
        return cafesDatasource[indexPath.row]
    }
    
    func didSelectCellAt(indexPath: IndexPath, navigationController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CafeDetailsViewController") as! CafeDetailsViewController
        let vcViewModel = CafeDetailsViewModel(cafe: cafesDatasource[indexPath.row].cafe)
        vcViewModel.favouriteChanged = {
            self.setupDatasource(cafes: self.appDelegate.appContext.cafesDatasource)
        }
        vc.viewModel = vcViewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
