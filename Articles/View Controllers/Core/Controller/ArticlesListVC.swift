//
//  ViewController.swift
//  Articles
//
//  Created by Gursewak Singh on 28/10/24.
//

import UIKit

class ArticlesListVC: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tbl_article: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableArticles()
    }
    
    private func setupTableArticles() {
        tbl_article.register(ArticlesListCell.nib, forCellReuseIdentifier: ArticlesListCell.identifier)
        tbl_article.estimatedRowHeight = 44
        tbl_article.rowHeight = UITableView.automaticDimension
    }


}


extension ArticlesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesListCell.identifier, for: indexPath) as? ArticlesListCell else { return UITableViewCell() }
        cell.configureCell()
            return cell
        
        
    }
    
    
}
