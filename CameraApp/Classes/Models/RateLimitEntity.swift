//
//  RateLimitEntity.swift
//  CameraApp
//
//  Created by Arata Sekine on 2019/01/06.
//  Copyright © 2019 Arata Sekine. All rights reserved.
//

import Foundation

struct RateLimit {
    let count: Int
    let resetDate: Date
    
    init?(dictionary: [String: AnyObject]) {
        guard let count = dictionary["rate"]?["limit"] as? Int else {
            return nil
        }
        
        guard let resetDateString = dictionary["rate"]?["reset"] as? TimeInterval else {
            return nil
        }
        
        self.count = count
        self.resetDate = Date(timeIntervalSince1970: resetDateString)
    }
}
