//
//  CafesListViewController.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 09/06/2021.
//

import UIKit

class CafesListViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var tableTopConstraint: NSLayoutConstraint!
    @IBOutlet private var cancelButton: UIButton!

    var viewModel: CafesListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cafe List"
        CafeListCell.register(to: tableView)
        tableView.estimatedRowHeight = 72
        tableView.rowHeight = UITableView.automaticDimension
        tableTopConstraint.constant = 0
        cancelButton.isHidden = true
        if viewModel == nil {
            viewModel = CafesListViewModel()
        } else {
            if viewModel.isFavouriteList {
                tableTopConstraint.constant = 66
                cancelButton.isHidden = false
                title = "Favourite Cafe List"
            } else {
                cancelButton.isHidden = true
                tableTopConstraint.constant = 0
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func tappedCancelButton(_ sender: Any) {
        viewModel.dismiss()
    }
}

extension CafesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = CafeListCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? CafeListCell else {
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
