//
//  ArticleTableViewCell.swift
//  ShahbazKhanTest
//
//  Created by admin on 10/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet var userImgView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userDesg: UILabel!
    
    @IBOutlet var articleDate: UILabel!
    @IBOutlet var articleImgView: UIImageView!
    @IBOutlet var articleContent: UILabel!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleUrl: UILabel!
    @IBOutlet var likes: UILabel!
    @IBOutlet var comments: UILabel!
    @IBOutlet var ArticleImageViewHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        self.userImgView.layer.cornerRadius = self.userImgView.frame.size.width / 2.0;
        self.userImgView.layer.borderWidth = 3.0;
        self.userImgView.layer.borderColor = UIColor.lightGray.cgColor;
        self.userImgView.clipsToBounds = true;
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
