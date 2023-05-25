//
//  Parse.swift
//  Test
//
//  Created by Ratchapol Pattarakanoksiri on 17/5/2566 BE.
//

import Foundation

struct Parse {
    
    static func jsonGenericObject<T: Decodable>(with responses:[String:Any], type: T.Type) -> T? {
        guard let jsonData = try? responses.data() else {
//            let result = try? JSONDecoder().decode(T.self, from: jsonData) else {
//                return nil
            return nil
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch let error as NSError {
            print(error)
            return nil
        }
//        return result
    }
    
    static func fromJsonString<T: Decodable>(_ json: String, type: T.Type) -> T? {
        guard let jsonData = json.data(using: .utf8) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(T.self, from: jsonData)
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
    
    static func jsonToDict(_ json: String) -> [String: Any]? {
        guard let jsonData = json.data(using: .utf8) else {
            return nil
        }
        do {
           return try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        } catch let error as NSError {
            print(error)
            return nil
        }
    }

}
