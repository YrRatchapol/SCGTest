//
//  NewsCell.swift
//  News
//
//  Created by Ratchapol Pattarakanoksiri on 23/5/2566 BE.
//

import UIKit
import AlamofireImage

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(imageUrlString: String, titleString: String, detail: String, dateTime: String) {
        if let url = URL(string: imageUrlString) {
            bannerImageView.af.setImage(withURL: url)
        }
        
//        bannerImageView.loadFrom(URLAddress: imageUrlString)
        titleLabel.text = titleString
        detailLabel.text = detail
        dateTimeLabel.text = "Updated: \(dateTime)"
    }

}
