//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-05.
//

import UIKit

class UserInfoViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
         let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
        
        print(username!)
    }

    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}
