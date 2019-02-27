//
//  GoogleVisionEntity.swift
//  CameraApp
//
//  Created by Arata Sekine on 2019/01/06.
//  Copyright © 2019 Arata Sekine. All rights reserved.
//

import Foundation

struct GoogleVision {
    let labels: [String]
    
    init?(dictionary: [String: AnyObject]) {
        print(dictionary)
        let responses = dictionary["responses"]?[0] as? [String: AnyObject]
        let _ = responses?["textAnnotations"] as? [[String: AnyObject]]
        guard let labelObjects = responses?["textAnnotations"] as? [[String: AnyObject]] else {
            return nil
        }
        
        self.labels = labelObjects.map {
            $0["description"] as! String
        }
    }
}
