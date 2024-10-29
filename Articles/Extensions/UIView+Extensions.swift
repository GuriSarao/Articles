//
//  UIView+Extensions.swift
//  Articles
//
//  Created by Gursewak Singh on 28/10/24.
//

import Foundation
import UIKit
extension UIView {
    // Method to set corner radius
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
//    
//    func applyCornerRadiusWithShadow(cornerRadius: CGFloat = 12, shadowRadius: CGFloat = 5, shadowOpacity: Float = 0.3, shadowColor: UIColor = .black, shadowOffset: CGSize = CGSize(width: 0, height: 2)) {
//        // Apply corner radius
//        self.layer.cornerRadius = cornerRadius
//        self.clipsToBounds = true
//        // Shadow setup
//        self.layer.masksToBounds = false
//        self.layer.shadowRadius = shadowRadius
//        self.layer.shadowOpacity = shadowOpacity
//        self.layer.shadowColor = shadowColor.cgColor
//        self.layer.shadowOffset = shadowOffset
//    }
//    
//    
    func applyCornerRadiusWithShadow(cornerRadius: CGFloat = 12, shadowRadius: CGFloat = 5, shadowOpacity: Float = 0.3, shadowColor: UIColor = .black, shadowOffset: CGSize = CGSize(width: 0, height: 2)) {
        // Apply corner radius
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true // Ensures the content inside the view follows the rounded corners

        // Shadow setup on a superview
        if let superview = self.superview {
            superview.layer.cornerRadius = cornerRadius
            superview.layer.shadowRadius = shadowRadius
            superview.layer.shadowOpacity = shadowOpacity
            superview.layer.shadowColor = shadowColor.cgColor
            superview.layer.shadowOffset = shadowOffset
            superview.layer.masksToBounds = false // This is necessary to show the shadow outside the bounds
        }
    }

}
