//
//  NYMedia.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 11/29/23.
//

import UIKit

struct NYMedia: DataArray {
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let approved_for_syndication: Int
    let media_metadata: [NYImage]

    init(type: String, subtype: String, caption: String, copyright: String, approved_for_syndication: Int, media_metadata: [NYImage]) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approved_for_syndication = approved_for_syndication
        self.media_metadata = media_metadata
    }

    init?(json: JsonDictionary) {
        let type = json["type"] as? String ?? ""
        let subtype = json["subtype"] as? String ?? ""
        let caption = json["caption"] as? String ?? ""
        let copyright = json["copyright"] as? String ?? ""
        let approved_for_syndication = json["approved_for_syndication"] as? Int ?? 0
        let media_metadata = NYImage.createRequiredInstances(from: json , key: "media-metadata") ?? []

        self.init(type: type, subtype: subtype, caption: caption, copyright: copyright, approved_for_syndication: approved_for_syndication, media_metadata: media_metadata)
    }
}
