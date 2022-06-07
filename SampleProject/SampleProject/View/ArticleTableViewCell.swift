//
//  ArticleTableViewCell.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 28/05/22.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageView_: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
