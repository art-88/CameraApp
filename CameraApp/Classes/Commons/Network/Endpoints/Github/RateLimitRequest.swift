//
//  RateLimitRequest.swift
//  CameraApp
//
//  Created by Arata Sekine on 2019/01/06.
//  Copyright © 2019 Arata Sekine. All rights reserved.
//

import Foundation
import APIKit

struct GetRateLimitRequest: GitHubRequest {
    typealias Response = RateLimit
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/rate_limit"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let dictionary = object as? [String: AnyObject],
            let rateLimit = RateLimit(dictionary: dictionary) else {
                throw ResponseError.unexpectedObject(object)
        }
        
        return rateLimit
    }
}
