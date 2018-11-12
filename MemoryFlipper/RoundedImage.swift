//
//  RoundedImage.swift
//  MemoryFlipper
//
//  Created by Sergey Gerashchenko on 11/11/18.
//  Copyright © 2018 Sergey Gerashchenko. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    private func configure() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12.0
    }
}
