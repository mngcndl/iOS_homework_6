//
//  APITarget.swift
//  homework_5
//
//  Created by Liubov on 13.07.2023.
//

import Foundation
import Moya

enum APITarget{
    case getCharacters
}

extension APITarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://rickandmortyapi.com") else {
            fatalError("Sorry, the url can not be found.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "/api/character"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestParameters(parameters: ["page": 1], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json", "Cache-Control": "no-cache"]
    }
}
