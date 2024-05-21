//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Alejandro Cervantes on 2024-05-20.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
