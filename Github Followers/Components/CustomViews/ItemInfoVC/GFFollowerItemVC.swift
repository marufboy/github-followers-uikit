//
//  GFFollowerItemVC.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 17/02/24.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didtapGetFollowers(for user: UserModel)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate!
    
    init(user: UserModel, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemHeaderView.set(itemInfoType: .followers, with: user.followers)
        itemSubHeaderView.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didtapGetFollowers(for: user)
    }
}
