//
//  GFRepoItemVC.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 17/02/24.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemHeaderView.set(itemInfoType: .repos, with: user.publicRepos)
        itemSubHeaderView.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
