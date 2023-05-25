//
//  Network.swift
//  Test
//
//  Created by Ratchapol Pattarakanoksiri on 17/5/2566 BE.
//

import Alamofire
import Foundation

typealias GenericCompletionBlock<T> = ( _ object : T ) -> Void
typealias FailureBlock = (_ error: ErrorEvent) -> Void

class Network {
    static func getRequest<T: Decodable>(request: BaseRequestProtocol? = EmptyRequest(),
                                         completion:@escaping GenericCompletionBlock<T>,
                                         failureBlock:@escaping FailureBlock) {
        AF.request(request?.url ?? "", method: .get)
            .validate()
            .response { response in
                switch response.result {
                case .success(let data):
                    do {
                        let resDic = try JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any]
                        guard let result = Parse.jsonGenericObject(with: resDic ?? [:], type: T.self) else {
                            failureBlock(ErrorEvent.parsing)
                            return
                        }
                        completion(result)
                    } catch {
                        failureBlock(ErrorEvent.response)
                    }
                case .failure(let error):
                    print("API call failed with error: \(error)")
                }
            }
    }
}
