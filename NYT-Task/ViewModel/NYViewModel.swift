//
//  NYViewModel.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 11/29/23.
//

import Foundation

protocol ViewModelDelegate {
    func updateList()
}

class NYViewModel {

    var articles = [NYModel]()
    var mpNewsAPI: MPNewsAPI?
    var delegate: ViewModelDelegate?

    init() {
        mpNewsAPI = MPNewsAPI()
    }

    /// API Call to fetch the latest news on basis of period value.
    func getNews(period: Int) {
        guard let api = mpNewsAPI else { return }
        api.getNews(page: 0, period: period) { [weak self](response) in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.articles = result.results
                self.delegate?.updateList()
            case.failure:
                break
            }
        }
    }
}
