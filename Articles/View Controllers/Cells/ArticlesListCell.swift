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
    @IBOutlet weak var widthImg: NSLayoutConstraint!
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
        view_bg.setCornerRadius(12)
        
        if article.urlToImage ?? "" == "" {
            
        }
        lbl_time.text = article.publishedAt.toFormattedDateString()
        lbl_title.text = article.title
        lbl_description.text = article.description
        
        if let url = article.urlToImage, url.isEmpty {
            widthImg.constant = 0
            
        }else {
            widthImg.constant = 130

        }
        if let imageUrl = URL(string: article.urlToImage ?? "") {
            
            img_article.kf.setImage(with: imageUrl,
                                    options: [
                                        .cacheOriginalImage // Caches the original image
                                    ])
            
            img_article.contentMode = .scaleAspectFill

        }
        
        self.view_bg_img.applyCornerRadiusWithShadow(shadowOffset: .zero)
//        self.view_bg_img.clipsToBounds = true
        
    }
}
