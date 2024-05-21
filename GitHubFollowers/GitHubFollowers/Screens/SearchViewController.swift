//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-01.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextfield = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemMint, title: "Get Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isUsernameEntered: Bool { return !usernameTextfield.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubviews(logoImageView, usernameTextfield, callToActionButton)
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextfield.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerList() {
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who look for 😀", buttonTitle: "Ok")
            return
        }
        
        usernameTextfield.resignFirstResponder() //view.endEditing(true)
        
        let followerListVC = FollowerListViewController(username: usernameTextfield.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImageView() {
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        logoImageView.contentMode = .scaleAspectFit
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        logoImageViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        
        usernameTextfield.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextfield.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        
        callToActionButton.addTarget(self, action: #selector(pushFollowerList), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerList()
        return true
    }
}
