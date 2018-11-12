//
//  CardCellCollectionViewCell.swift
//  MemoryFlipper
//
//  Created by Sergey Gerashchenko on 11/11/18.
//  Copyright © 2018 Sergey Gerashchenko. All rights reserved.
//

import UIKit


fileprivate let backImage = UIImage.init(named: "generic")

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: RoundedImage!
    
    private(set) var isOpen: Bool = false
    private var image: UIImage!
    
    
    class func reuseId() -> String {
        
        return String(describing: self)
    }
    
    func setData(_ image: UIImage) {
        self.image = image
    }
    
    func flip() {
        self.isOpen.toggle()
        
        if self.isOpen {
            cardImage.image = image
        } else {
            cardImage.image = backImage
        }
        
        UIView.transition(with: cardImage, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    
    func getCardHash() -> Int {
        return self.image.hashValue
    }
    
    func flipUp() {
        if !self.isOpen {
            self.isOpen.toggle()
            self.cardImage.image = image
            
            UIView.transition(with: cardImage, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
    
    func flipDown() {
        if self.isOpen {
            self.isOpen.toggle()
            self.cardImage.image = backImage
            
            UIView.transition(with: cardImage, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
}
