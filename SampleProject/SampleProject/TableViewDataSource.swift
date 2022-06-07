//
//  TableViewDataSource.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 28/05/22.
//

import Foundation
import UIKit

protocol SPTableViewDataSource {
    
}

class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDataSourcePrefetching, SPTableViewDataSource {
    
    //SDWebImage
    
    let modelCache = NSCache<NSUUID, Article>()
    var articles : [Article] = []
    var tableViewController: TableViewController!
    var tableViewModel: TableViewModel = TableViewModel()
    
    init(items: [Article], viewController: TableViewController) {
        super.init()
        articles = items
        tableViewController = viewController
        viewController.dataSource = self
        viewController.prefetchDataSource = self
        viewController.setUpDataSource()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCellIdentifier, for: indexPath) as? ArticleTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: "defaultIdentifier", for: indexPath)
        }
        let articleModel = articles[indexPath.row]
        // Configure the cell...
        if let imageSrc = articleModel.image?.src as? String, let imageUrl = URL(string: imageSrc) {
            ConnectionHandler.getImageFromUrl(src: imageUrl, success: { image in
                DispatchQueue.main.async {
                    cell.imageView_.image = image
                }
            })
            cell.title.text = articleModel.title
            cell.summary.attributedText = tableViewModel.getAttributedStringFor(html: articleModel.summary_html)
            cell.imageHeightConstraint.constant = CGFloat(articleModel.image?.resizeHeight ?? 0.0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            for indexPath in indexPaths {
                guard let articleModel = self?.articles[indexPath.row] else { return }
                if let uuid = NSUUID(uuidString: String(articleModel.id)), self?.modelCache.object(forKey: uuid) == nil {
                    self?.modelCache.setObject(articleModel, forKey: uuid)
                }
            }
        }
    }
    
    func getCurrentArticleModel(index: Int) -> Article {
        return articles[index]
    }
}
