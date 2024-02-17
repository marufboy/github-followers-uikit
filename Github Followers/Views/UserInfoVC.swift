//
//  UserInfoVC.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 09/02/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView          = UIView()
    let itemHeaderView      = UIView()
    let itemSubHeaderView   = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBaseVC()
        configureUI()
        getUserInfo()
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
                    self.add(childVC: GFRepoItemVC(user: user), to: self.itemHeaderView)
                    self.add(childVC: GFFollowerItemVC(user: user), to: self.itemSubHeaderView)
                    self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
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
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemHeaderView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemHeaderView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemSubHeaderView.topAnchor.constraint(equalTo: itemHeaderView.bottomAnchor, constant: padding),
            itemSubHeaderView.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemSubHeaderView.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
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

#Preview {
    let vc = UserInfoVC()
    vc.username = "sallen0400"
    
    return vc
}
