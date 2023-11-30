//
//  NYModel.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 11/29/23.
//

import Foundation

struct NYModel: DataArray {

    let id: Double
    let asset_id: Double
    let url: String
    let column: String
    let section: String
    let byline: String
    let type: String
    let title: String
    let abstract: String
    let published_date: String
    let source: String
    let views: Int
    let des_facet: String
    let org_facet: String
    let per_facet: [String]
    let geo_facet: [String]
    let media: [NYMedia]

    init(id: Double, asset_id: Double, url: String, column: String, section: String, byline: String, type: String, title: String, abstract: String, published_date: String, source: String, views: Int, des_facet: String, org_facet: String, per_facet: [String], geo_facet: [String], media: [NYMedia]) {
        self.id = id
        self.asset_id = asset_id
        self.url = url
        self.column = column
        self.section = section
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.published_date = published_date
        self.source = source
        self.views = views
        self.des_facet = des_facet
        self.org_facet = org_facet
        self.per_facet = per_facet
        self.geo_facet = geo_facet
        self.media = media
    }

    init?(json: JsonDictionary) {
        let id = json["id"] as? Double ?? 0
        let asset_id = json["asset_id"] as? Double ?? 0
        let url = json["url"] as? String ?? ""
        let column = json["column"] as? String ?? ""
        let section = json["section"] as? String ?? ""
        let byline = json["byline"] as? String ?? ""
        let type = json["type"] as? String ?? ""
        let title = json["title"] as? String ?? ""
        let abstract = json["abstract"] as? String ?? ""
        let published_date = json["published_date"] as? String ?? ""
        let source = json["source"] as? String ?? ""
        let views = json["views"] as? Int ?? 0
        let des_facet = json["des_facet"] as? String ?? ""
        let org_facet = json["org_facet"] as? String ?? ""
        let per_facet = json["per_facet"] as? [String] ?? []
        let geo_facet = json["geo_facet"] as? [String] ?? []
        let media = NYMedia.createRequiredInstances(from: json , key: "media") ?? []

        self.init(id: id, asset_id: asset_id, url: url, column: column, section: section, byline: byline, type: type, title: title, abstract: abstract, published_date: published_date, source: source, views: views, des_facet: des_facet, org_facet: org_facet, per_facet: per_facet, geo_facet: geo_facet, media: media)
    }
}
