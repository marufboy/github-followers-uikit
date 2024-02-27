//
//  GFAlertContainerView.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 27/02/24.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor           = .systemBackground
        layer.cornerRadius        = 16
        layer.borderWidth         = 2
        layer.borderColor         = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
