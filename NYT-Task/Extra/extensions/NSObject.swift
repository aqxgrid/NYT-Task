//
//  NSObject.swift
//  NYT-Task
//
//  Created by Abdul Qadar on 30/11/2023.
//

import UIKit

protocol DataArray {
    init?(json: JsonDictionary)
}

extension DataArray {
    static func createRequiredInstances(from json: JsonDictionary , key:String) -> [Self]? {
        guard let jsonDictionaries = json[key] as? [[String: Any]] else { return nil }
        var array = [Self]()
        for jsonDictionary in jsonDictionaries {
            guard let instance = Self.init(json: jsonDictionary) else { return nil }
            array.append(instance)
        }
        return array
    }
}

extension NSObject {
    class var stringFromClass: String {
        let name = String(describing: self)
        return name
    }
}
