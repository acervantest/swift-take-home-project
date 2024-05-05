//
//  GFAvatarImageview.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-04.
//

import UIKit

class GFAvatarImageview: UIImageView {

    let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        clipsToBounds = true // makes the actual image round according to the corner radius
        image = placeholderImage
    }
    
    func setImage(from urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            self.image = image
        }
    }

}
