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
}
