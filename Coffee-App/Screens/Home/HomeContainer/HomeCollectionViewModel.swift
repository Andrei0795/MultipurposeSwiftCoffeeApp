//
//  HomeContainerViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

enum HomeCollectionViewType {
    case actions
    case newCafes
}

protocol HomeCollectionViewModel {
    var type: HomeCollectionViewType! { get set }
    var navigationController: UINavigationController! { get set }

    func cellViewModel(at indexPath: IndexPath) -> HomeCollectionCellViewModelProtocol
    func numberOfCells() -> Int
    func didSelectItem(at indexPath: IndexPath)
}


class NewCafesCollectionViewModel: HomeCollectionViewModel {
    
    private var appDelegate: AppDelegate!
    var type: HomeCollectionViewType!
    var navigationController: UINavigationController!
    private var newCafes: [Cafe]
    private var newCafesDatasource = [NewCafesCellViewModel]()
    
    init(type: HomeCollectionViewType, navigationController: UINavigationController, newCafes: [Cafe]) {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.type = type
        self.navigationController = navigationController
        self.newCafes = newCafes
        setupDatasource()
    }
    
    private func setupDatasource() {
        for cafe in newCafes {
            if let id = cafe.id, let title = cafe.title {
                let cellViewModel = NewCafesCellViewModel(cafeID: id, title: title, imageLink: cafe.imageLink)
                newCafesDatasource.append(cellViewModel)
            }
        }
    }
    
    func numberOfCells() -> Int {
        return newCafes.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HomeCollectionCellViewModelProtocol {
        return newCafesDatasource[indexPath.row]
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
}

class ActionsCollectionViewModel: HomeCollectionViewModel {
    
    var type: HomeCollectionViewType!
    var navigationController: UINavigationController!
    init(type: HomeCollectionViewType, navigationController: UINavigationController) {
        self.type = type
        self.navigationController = navigationController
    }
    
    func numberOfCells() -> Int {
        return 3
    }
    
    func cellViewModel(at indexPath: IndexPath) -> HomeCollectionCellViewModelProtocol {
        switch indexPath.row {
        case 0:
            return HomeActionCellViewModel(type: .about)
        case 1:
            return HomeActionCellViewModel(type: .favourites)
        case 2:
            return HomeActionCellViewModel(type: .gallery)
        default:
            assertionFailure("Should not happen")
            return HomeActionCellViewModel(type: .about)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            displayAbout()
        case 1:
            displayFavourites()
        case 2:
            displayGallery()
            print("Coming Soon!")
        default:
            assertionFailure("Should not happen")
        }
    }
    
    
    private func displayAbout() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        vc.modalPresentationStyle = .fullScreen
        let vcViewModel = AboutViewModel()
        vcViewModel.dismissBlock = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        vc.viewModel = vcViewModel
        vc.title = "About"
        navigationController.present(vc, animated: true)
    }
    
    private func displayFavourites() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CafesListViewController") as! CafesListViewController
        let vcViewModel = CafesListViewModel(isFavouriteList: true)
        vcViewModel.dismissBlock = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        vc.viewModel = vcViewModel
        vc.title = "Favourite Cafes"
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }
    
    private func displayGallery() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MyCafesMemoriesViewController") as! MyCafesMemoriesViewController
        let vcViewModel = MyCafesMemoriesViewModel()
        vcViewModel.delegate = vc
        vcViewModel.dismissBlock = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        vc.viewModel = vcViewModel
        vc.title = "Memories List"
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }
}
