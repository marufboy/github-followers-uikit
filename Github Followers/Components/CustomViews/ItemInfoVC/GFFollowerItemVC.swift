//
//  GFFollowerItemVC.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 17/02/24.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemHeaderView.set(itemInfoType: .followers, with: user.followers)
        itemSubHeaderView.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
