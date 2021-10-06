//
//  MyCafesMemoriesViewModel.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

protocol MyCafesMemoriesViewModelDelegate: class {
    func MyCafesMemoriesViewModelDidUpdateData(viewModel: MyCafesMemoriesViewModel)
}

class MyCafesMemoriesViewModel {
    var memoriesDatasource = [MemoryListCellViewModel]()
    var dismissBlock: (() -> Void)?
    weak var delegate: MyCafesMemoriesViewModelDelegate?
    
    init() {
        setupDatasource()
    }
    
    func dismiss() {
        dismissBlock?()
    }
    
    func setupDatasource() {
        memoriesDatasource.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        guard let realmMemories = appDelegate.appContext.realmManager.getMemoryObjects() else {
            return
        }
        
        for realmMemory in realmMemories {
            let memory = realmMemory.asMemory()
            let cellViewModel = MemoryListCellViewModel(memory: memory)
            memoriesDatasource.append(cellViewModel)
            
        }
    }
    
    func tappedAdd(navigationController: UINavigationController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddNewMemoryViewController") as! AddNewMemoryViewController
        let vcViewModel = AddNewMemoryViewModel()
        let picker = ImagePicker(presentationController: vc, delegate: vcViewModel)
        vcViewModel.imagePicker = picker
        vcViewModel.dismissBlock = {
            navigationController.popViewController(animated: true)
            self.setupDatasource()
            self.delegate?.MyCafesMemoriesViewModelDidUpdateData(viewModel: self)

        }
        vc.viewModel = vcViewModel
        vc.title = "Add Memory"
        navigationController.pushViewController(vc, animated: true)
    }
    
    func numberOfRows() -> Int {
        return memoriesDatasource.count
    }
    
    func cellViewModelAt(indexPath: IndexPath) -> MemoryListCellViewModel {
        return memoriesDatasource[indexPath.row]
    }
    
    func didSelectCellAt(indexPath: IndexPath, navigationController: UINavigationController) {
        let memory = memoriesDatasource[indexPath.row].memory
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MemoryDetailsViewController") as! MemoryDetailsViewController
        let vcViewModel = MemoryDetailsViewModel(memory: memory)
        vcViewModel.deleteBlock = {
            navigationController.popViewController(animated: true)
            self.setupDatasource()
            self.delegate?.MyCafesMemoriesViewModelDidUpdateData(viewModel: self)

        }
        vc.viewModel = vcViewModel
        vc.title = "Memory Details"
        navigationController.pushViewController(vc, animated: true)
    }
}
