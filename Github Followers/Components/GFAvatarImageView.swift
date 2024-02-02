//
//  GFAvatarImageView.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 02/02/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImg = UIImage(resource: .avatarPlaceholder)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImg
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
