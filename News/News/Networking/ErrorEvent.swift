//
//  ErrorEvent.swift
//  Test
//
//  Created by Ratchapol Pattarakanoksiri on 17/5/2566 BE.
//

import UIKit
import Alamofire

enum ErrorEvent: Error {
    case parsing
    case request
    case response
    case invalid
    case unexpected
    case custom(message:String?)
    
    var localizedDescription: String {
        switch self {
        case .parsing:              return "Parsing Error"
        case .request:              return "Request Error"
        case .response:             return "Response Error"
        case .invalid:              return "Invalid Error"
        case .unexpected:           return "Unexpected Error"
        case .custom(let message):
            return message ?? "Unknown Error"
        }
    }
}
