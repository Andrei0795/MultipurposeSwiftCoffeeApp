//
//  MyCafesMemoriesViewController.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class MyCafesMemoriesViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var cancelButton: UIButton!
    @IBOutlet private var addButton: UIButton!

    var viewModel: MyCafesMemoriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Memories List"
        MemoryListCell.register(to: tableView)
        tableView.estimatedRowHeight = 72
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func tappedCancelButton(_ sender: Any) {
        viewModel.dismiss()
    }
    
    @IBAction func tappedAddButton(_ sender: Any) {
        guard let navigationController = navigationController else {
            return
        }
        viewModel.tappedAdd(navigationController: navigationController)
    }
}

extension MyCafesMemoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = MemoryListCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MemoryListCell else {
            assertionFailure("Unable to dequeue cell")
            return UITableViewCell()
        }
        cell.cellViewModel = viewModel.cellViewModelAt(indexPath: indexPath)
        
        if indexPath.row == viewModel.numberOfRows() - 1 {
            cell.hideSeparator()
        } else {
            cell.showSeparator()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else {
            return
        }
        viewModel.didSelectCellAt(indexPath: indexPath, navigationController: navigationController)
    }
}

extension MyCafesMemoriesViewController: MyCafesMemoriesViewModelDelegate {
    func MyCafesMemoriesViewModelDidUpdateData(viewModel: MyCafesMemoriesViewModel) {
        tableView.reloadData()
    }
}
