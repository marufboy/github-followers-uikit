//
//  UserInfoVC.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 09/02/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {
    
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    
    let headerView          = UIView()
    let itemHeaderView      = UIView()
    let itemSubHeaderView   = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBaseVC()
        configureScrollView()
        configureUI()
        getUserInfo()
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func configureUIElements(with user: UserModel) {
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemHeaderView)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemSubHeaderView)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func configureBaseVC() {
        view.backgroundColor    = .systemBackground
        let doneBUtton          = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneBUtton
    }
    
    func configureUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        itemViews   = [headerView, itemHeaderView, itemSubHeaderView, dateLabel]
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemHeaderView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemHeaderView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemSubHeaderView.topAnchor.constraint(equalTo: itemHeaderView.bottomAnchor, constant: padding),
            itemSubHeaderView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemSubHeaderView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: Func add all component
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}

extension UserInfoVC: GFRepoItemVCDelegate {
    func didTapGitHubProfile(for user: UserModel) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
    }
}

extension UserInfoVC: GFFollowerItemVCDelegate {
    func didtapGetFollowers(for user: UserModel) {
        guard user.followers !=  0 else { presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers 🥹.", buttonTitle: "Ok")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}

#Preview {
    let vc = UserInfoVC()
    vc.username = "sallen0400"
    
    return vc
}
