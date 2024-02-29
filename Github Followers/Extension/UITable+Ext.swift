//
//  UITable+Ext.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 29/02/24.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
