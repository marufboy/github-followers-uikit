//
//  GFAvatarImageView.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 02/02/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache          = NetworkManager.shared.cache
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
    
    func donwloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async { self.image = image }
        }
        
        task.resume()
    }
}
