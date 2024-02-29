//
//  GFAvatarImageView.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 02/02/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache          = NetworkManager.shared.cache
    let placeholderImg = Images.placeholder

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
    
    func donwloadAvatarImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image  = image }
        }
    }
}
