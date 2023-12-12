//
//  APIClient+TargetType.swift
//  ColorBookMarkV2
//
//  Created by SUN on 2023/07/02.
//

import Moya
import Foundation

extension APIClient: TargetType {
    var baseURL: URL {
        guard let url = URL(string: K.baseURL) else {
            fatalError("base url not found")}
        return url
    }
    
    var path: String {
        switch self {
        case .signUp:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signUp:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var headersWithoutToken: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
}
