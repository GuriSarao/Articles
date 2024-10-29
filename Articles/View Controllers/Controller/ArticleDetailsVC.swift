//
//  ArticleDetailsVC.swift
//  Articles
//
//  Created by Gursewak Singh on 29/10/24.
//

import UIKit
import Alamofire

class ArticleDetailsVC: UIViewController {
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var img_article: UIImageView!
    @IBOutlet weak var view_img_article: UIView!
    @IBOutlet weak var lbl_description: UILabel!

    var title_text = ""
    var date = ""
    var description_text = ""
    var img = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        NetworkManager.shared.currentViewController = self
        
    }
    
    @IBAction func tap_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupData() {
        lbl_title.text = title_text
        lbl_date.text = date
        lbl_description.text = description_text
        if let imageUrl = URL(string: img) {
            
            img_article.kf.setImage(with: imageUrl,
                                    options: [
                                        .cacheOriginalImage // Caches the original image
                                    ]
            )
            img_article.contentMode = .scaleAspectFill

        }
        
            self.view_img_article.applyCornerRadiusWithShadow()

    }
}
