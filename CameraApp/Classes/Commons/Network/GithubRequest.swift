//
//  GithubRequest.swift
//  CameraApp
//
//  Created by Arata Sekine on 2019/01/06.
//  Copyright © 2019 Arata Sekine. All rights reserved.
//

import Foundation
import APIKit

protocol GitHubRequest: Request {
}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}
