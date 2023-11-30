//
//  MPNewsAPI.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 30/11/2023.
//

import Foundation

enum NewsAPIResponse {
    case success(result: NewsArray)
    case failure
}

class MPNewsAPI: Service {

    func getNews(page:Int, period: Int, completion: @escaping (NewsAPIResponse) -> Void ) {
        super.callEndPoint(endPoint:.getPopular, period: period) { [weak self] (response) in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.parseResult(result: result, completion: completion)
                break
            default:
                completion(.failure)
                break
            }
        }
    }

    /// Parse the response
    private func parseResult(result: JsonDictionary, completion: @escaping (NewsAPIResponse) -> Void) {
        guard let data = NewsArray(json: result) else {
            completion(.failure)
            return
        }
        completion(.success(result: data))
    }
}
