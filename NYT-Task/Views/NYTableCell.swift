//
//  NYTableCell.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 30/11/2023.
//

import UIKit

class NYTableCell: UITableViewCell {

    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsBy: UILabel!
    @IBOutlet weak var lblNewsDate: UILabel!
    @IBOutlet weak var imagView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(article: NYModel?) {
        lblNewsTitle.text = article?.title ?? APIConstants.unkown_title
        lblNewsBy.text = article?.byline ?? APIConstants.unkown_author
        lblNewsDate.text = Utilities.formateDate(date: article?.published_date ?? Utilities.fakeDate())
        let media_array = article?.media ?? []
        if (media_array.count > 0) {
            let media = media_array[0]
            let metadata_array = media.media_metadata
            if (metadata_array.count > 0) {
                let image = metadata_array[0]
                imagView?.image(url: image.url)
            }
        }
    }
}
