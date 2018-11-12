//
//  RandomService.swift
//  MemoryFlipper
//
//  Created by Sergey Gerashchenko on 11/11/18.
//  Copyright © 2018 Sergey Gerashchenko. All rights reserved.
//

import UIKit


class RandomService {
    
    private let image1 = UIImage(named: "img_1")
    private let image2 = UIImage(named: "img_2")
    private let image3 = UIImage(named: "img_3")
    private let image4 = UIImage(named: "img_4")
    private let image5 = UIImage(named: "img_5")
    private let image6 = UIImage(named: "img_6")
    
    static func generate() -> [UIImage] {
        var result: [UIImage] = []
        var currentImageNumber: Int = 1
        
        while result.count <= 15 {
            let seed = Int.random(in: 2...3)
            print("Seed: \(seed)")
            
            for _ in 0..<seed {
                guard let image = UIImage(named: "img_" + String(currentImageNumber)) else {
                    
                    assert(false)
                    return []
                }
                
                result.append(image)
            }
            
            if currentImageNumber <= 5 {
                currentImageNumber += 1
            }
        }
        result.shuffle()
        
        print("count: \(result.count)")
        return result
    }
    
    private init() {}
    
}
