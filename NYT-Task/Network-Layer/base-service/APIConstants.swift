//
//  APIConstants.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 30/11/2023.
//

import UIKit
import Foundation

struct APIConstants {
    static let unkown_title  = "Breaking News"
    static let unkown_author = "By Unkown"
    static let unkown_abst   = "Empty"
    static let image_format  = "mediumThreeByTwo440"
    static let protocols     = "https://"
    static let apiVersion    = "/v2"
    static let domain        = "api.nytimes.com/svc"
    static let subDomain     = "/mostviewed"
    static let section       = "/all-sections"
    static let apiKey        = "RhUZGRAZenFeIrBpAWYrD1hsY0ZHjGz7"//"ADYf7cnwk6WOZNfRsUe4XZvke5KkGf6f"
    static let keyPath       = "api-key="
    static let urlExtension  = ".json?"
    static let baseUrl       = APIConstants.protocols + APIConstants.domain
}

public enum APIEndPoint: String {
    case getPopular = "/mostpopular"
}

public struct APIEndPoints {
    private let types: [APIEndPoint] = [
        .getPopular
    ]
}
