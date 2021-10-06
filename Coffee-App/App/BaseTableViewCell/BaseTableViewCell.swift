//
//  BaseTableViewCell.swift
//  Coffee-App
//
//  Created by Andrei Ionescu on 14/06/2021.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    private var separatorView: UIView?
    
    func hideSeparator() {
        separatorView?.isHidden = true
    }
    
    func showSeparator() {
        separatorView?.isHidden = false
    }
    
    func addSeparatorView(insets: UIEdgeInsets? = nil) {
            if separatorView != nil {
                return
            }
            
            separatorView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 1))
            separatorView!.backgroundColor = UIColor.gray
            separatorView!.pinBottom(to: self, insets: insets ?? UIEdgeInsets.init(top: 0, left: 16, bottom: 0, right: -16))
            separatorView!.setHeightConstraint(heightConstant: 1)
        }
}
