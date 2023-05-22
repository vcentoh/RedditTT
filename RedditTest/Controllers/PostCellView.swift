//
//  PostCellViewController.swift
//  RedditTest
//
//  Created by Magik on 21/5/23.
//

import UIKit
import SDWebImage

let placheHolder = URL(string: "https://b.thumbs.redditmedia.com/kN68dItAJCmRRXJCD_I65xNa3eqBKtVS_ZZrK5AvxEQ.jpg")

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
        var imageURL = URL(string: post.thumbnail) ?? placheHolder
        self.previewImage.sd_setImage(with: imageURL  )
        { (img, error, cache, url) in
            self.haldeSDW(image: img, err: error, chache: cache, url: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         
    }
    
    func haldeSDW(image: UIImage?, err: Error?, chache: SDImageCacheType, url: URL?) {
        if let err = err {
            dump(err)
            return
        }
        guard let image = image, let url = url else { return }
        let msg = "Success"
        print(url)
        
    }
}
