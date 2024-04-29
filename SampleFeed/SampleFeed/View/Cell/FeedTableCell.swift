//
//  FeedTableCell.swift
//  SampleFeed
//
//  Created by Nitish Kumar on 29/04/24.
//

import UIKit

class FeedTableCell: UITableViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    var PostData : Post? {
        didSet{
            userIdLabel.text = "user_\(PostData?.userId ?? 0)"
            idLabel.text = "post_\(PostData?.id ?? 0)"
            titleLabel.text = PostData?.title
            bodyLabel.text = PostData?.body
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
