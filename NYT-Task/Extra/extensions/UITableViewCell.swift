//
//  UITableViewCell.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 30/11/2023.
//

import UIKit

extension UITableViewCell {

    static func registerCellXib(with tableview: UITableView){
        let nib = UINib(nibName: "\(self)", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "\(self)")
    }
}
