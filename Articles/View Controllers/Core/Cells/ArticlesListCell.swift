//
//  ArticlesListCell.swift
//  Articles
//
//  Created by Gursewak Singh on 28/10/24.
//

import UIKit
import Kingfisher
class ArticlesListCell: UITableViewCell {
    @IBOutlet weak var view_bg: UIView!
    @IBOutlet weak var view_bg_img: UIView!
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var img_article: UIImageView!
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
    
    func configureCell(article: Article) {
//        view_bg.setCornerRadius(12)
//        view_bg.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
//        view_bg.layer.shadowOpacity = 0.3 // Adjust the opacity
//        view_bg.layer.shadowOffset = CGSize(width: 0, height: 4) // Adjust the shadow offset
//        view_bg.layer.shadowRadius = 4 // Adjust the shadow radius
//        view_bg.layer.masksToBounds = false // Important for shadow to show
        
        view_bg.applyCornerRadiusWithShadow(cornerRadius: 12, shadowRadius: 1, shadowOpacity: 0.3, shadowOffset: .zero)
        lbl_time.text = article.publishedAt.toFormattedDateString()
        lbl_title.text = article.title
        lbl_description.text = article.description
        if let imageUrl = URL(string: article.urlToImage ?? "") {
            
            img_article.kf.setImage(with: imageUrl,
                                    options: [
                                        .cacheOriginalImage // Caches the original image
                                    ]
            )
            img_article.contentMode = .scaleAspectFill

        }
        
        self.view_bg_img.applyCornerRadiusWithShadow(shadowOffset: .zero)
//        self.view_bg_img.clipsToBounds = true
        
    }
}
