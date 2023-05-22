//
//  PostCellViewController.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import UIKit

class PostCellView: UITableViewCell {

    @IBOutlet weak var previewImage: UIImageView! = {
        let thumbnail = UIImageView()
        thumbnail.backgroundColor = .cyan
        return thumbnail
    }()
    @IBOutlet weak var titleLabel: UILabel! = {
        let label = UILabel()
        label.font.withSize(20)
        label.textColor = .red
        return label
    }()
    
    @IBOutlet weak var autorDateLabel: UILabel! = {
        let label = UILabel()
        label.font.withSize(12)
        label.textColor = .green
        return label
    }()
    
    func update(with post: RedditPost) {
        titleLabel.text = post.title
        autorDateLabel.text = post.user
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         
    }
}
