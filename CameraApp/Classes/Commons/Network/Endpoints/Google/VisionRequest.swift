//
//  VisionRequest.swift
//  CameraApp
//
//  Created by Arata Sekine on 2019/01/06.
//  Copyright © 2019 Arata Sekine. All rights reserved.
//

import Foundation
import APIKit

struct VisionRequest: Request {
    typealias Response = GoogleVision
    
    var googleAPIKey = "KEY"
    var base64image = ""
    
    var method: HTTPMethod {
        return .post
    }
    
    var baseURL: URL {
        return URL(string: "https://vision.googleapis.com")!
    }
    
    var path: String {
        return "/v1/images:annotate"
    }
    
    var headerFields: [String: String] {
        let identifier = Bundle.main.bundleIdentifier ?? ""
        return [
            "Content-Type": "application/json",
            "X-Ios-Bundle-Identifier": identifier
        ]
    }
    
    var queryParameters: [String: Any]? {
        return [
            "key": googleAPIKey
        ]
    }
    
    var parameters: Any? {
        return [
            "requests": [
                "image": [
                    "content": base64image
                ],
                "features": [
                    [
                        "type": "DOCUMENT_TEXT_DETECTION"
                    ]
                ]
            ]
        ]
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let dictionary = object as? [String: AnyObject],
            let responseModel = GoogleVision(dictionary: dictionary) else {
                throw ResponseError.unexpectedObject(object)
        }
        
        return responseModel
    }
}
