//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-04.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    private func configure() {
        configureMessageLabel()
        configureLogoImage()
    }
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 0 : -150
        let messageLabelCenterYconstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterYconstraint.isActive = true
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureLogoImage() {
        addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.emptyStateLogo

        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        let logoImageViewBottomConstraint = logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: logoBottomConstant)
        logoImageViewBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170)
        ])
    }
}
