//
//  NYDetailViewController.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 30/11/2023.
//

import UIKit

class NYDetailViewController: UIViewController {

    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsBy: UILabel!
    @IBOutlet weak var lblNewsDate: UILabel!
    @IBOutlet weak var imagView: UIImageView!
    var article: NYModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialData()
    }

    func setupInitialData() {
        lblNewsTitle.text = article?.title ?? APIConstants.unkown_title
        lblNewsBy.text = article?.abstract ?? APIConstants.unkown_abst
        lblNewsDate.text = Utilities.formateDate(date: article?.published_date ?? Utilities.fakeDate())
        let media_array = article?.media ?? []
        if (media_array.count > 0) {
            if let media = media_array.first {
                let metadata_array = media.media_metadata
                if (metadata_array.count > 0) {
                    for image in metadata_array {
                        if image.format == APIConstants.image_format {
                            imagView?.image(url: image.url)
                        }
                    }
                }
            }
        }
    }
}
