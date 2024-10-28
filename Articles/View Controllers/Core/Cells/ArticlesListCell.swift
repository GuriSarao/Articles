//
//  ArticlesListCell.swift
//  Articles
//
//  Created by Gursewak Singh on 28/10/24.
//

import UIKit

class ArticlesListCell: UITableViewCell {
    @IBOutlet weak var view_bg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    func configureCell() {
        view_bg.setCornerRadius(12)
        view_bg.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        view_bg.layer.shadowOpacity = 0.3 // Adjust the opacity
        view_bg.layer.shadowOffset = CGSize(width: 0, height: 4) // Adjust the shadow offset
        view_bg.layer.shadowRadius = 4 // Adjust the shadow radius
        view_bg.layer.masksToBounds = false // Important for shadow to show
    }
}
