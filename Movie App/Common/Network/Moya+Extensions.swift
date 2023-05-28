//
//  Moya+Extensions.swift
//  Movie App
//
//  Created by Nay Linn (WW) on 23/05/2023.
//

import Moya

extension TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "\(APIConfig.getBaseUrl())") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    func stubbedResponse(_ filename: String) -> Data! {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else { fatalError("path could not be found") }
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
