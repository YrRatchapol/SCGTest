//
//  Jsonable.swift
//  Test
//
//  Created by Ratchapol Pattarakanoksiri on 17/5/2566 BE.
//

import Foundation

protocol Jsonable: Encodable {
    func toJson() -> [String: Any]?
}

extension Jsonable {
    func toJson() -> [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(self), let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] else {
            return [:]
        }
        return dict
    }
}
