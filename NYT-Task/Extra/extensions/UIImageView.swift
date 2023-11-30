//
//  UIImageView.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 30/11/2023.
//

import Foundation
import UIKit

extension UIImageView {
    public func image(url: String) {
        let hudActivity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        hudActivity.color = .black
        hudActivity.center = self.center
        self.addSubview(hudActivity)
        hudActivity.startAnimating()
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.image = UIImage(data: data)
                    hudActivity.stopAnimating()
                    hudActivity.removeFromSuperview()
                }
            }
            task.resume()
        }
    }
}
