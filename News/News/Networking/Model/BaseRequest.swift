//
//  BaseRequest.swift
//  Test
//
//  Created by Ratchapol Pattarakanoksiri on 17/5/2566 BE.
//

import UIKit
import Alamofire

protocol BaseRequestProtocol: Jsonable {
    var url: String? { get }
    var parameters: Parameters? { get }
}

struct EmptyRequest: BaseRequestProtocol {
    var url: String? { get { return nil } }
    var parameters: Parameters? { get { return nil } }
}
