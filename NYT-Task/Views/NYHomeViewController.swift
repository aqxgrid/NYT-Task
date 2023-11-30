//
//  NYHomeViewController.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 30/11/2023.
//

import UIKit
import SwiftyProgressHud

class NYHomeViewController: UIViewController, ViewModelDelegate {

    var hud: SwiftyProgressHud!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = NYViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        NYTableCell.registerCellXib(with: tableView)
        viewModel.delegate = self
        hud = SwiftyProgressHud()
        hud.show(view: self.view)
        // User can pass any number in available list from API: [1, 7, 30]
        viewModel.getNews(period: 7)
    }

    func updateList() {
        DispatchQueue.main.sync {
            self.tableView.reloadData()
            hud.hide()
        }
    }
}

// MARK: - TableView Delegate & DataSource methods
extension NYHomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NYTableCell.stringFromClass) as! NYTableCell
        cell.configure(article: viewModel.articles[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = appDelegate().storyboard().instantiateViewController(withIdentifier: NYDetailViewController.stringFromClass) as? NYDetailViewController else { return }
        vc.article = viewModel.articles[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
