//
//  GFItemInfoVC.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 14/02/24.
//

import UIKit

protocol ItemInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: UserModel)
    func didtapGetFollowers(for user: UserModel)
}

class GFItemInfoVC: UIViewController {

    let stackView           = UIStackView()
    let itemHeaderView      = GFItemInfoView()
    let itemSubHeaderView   = GFItemInfoView()
    let actionButton        = GFButton()
    
    var user: UserModel!
    
    init(user: UserModel) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureActionButton()
        configureUI()
        configureStackView()
    }
    
    func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemHeaderView)
        stackView.addArrangedSubview(itemSubHeaderView)
    }
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {}

    private func configureUI() {
        view.addSubviews(stackView, actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat    = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

#Preview {
    let vc = GFItemInfoVC(user: UserModel(login: "", avatarUrl: "", publicRepos: 10, publicGists: 10, htmlUrl: "", following: 12, followers: 5, createdAt: .now))
    
    return vc
}
