//
//  ViewController.swift
//  MemoryFlipper
//
//  Created by Sergey Gerashchenko on 11/11/18.
//  Copyright © 2018 Sergey Gerashchenko. All rights reserved.
//

import UIKit

fileprivate let numberOfCells: Int = 15
fileprivate let cellSize = CGSize(width: 64.0, height: 64.0)

class GameController: UIViewController {
    
    @IBOutlet weak var cardsCollection: UICollectionView!
    private var gameData: [UIImage] = []
    private var activeCards: [CardCell] = []
    private var currentCardHash: Int?
    
    override func loadView() {
        super.loadView()
        
        self.gameData = RandomService.generate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.cardsCollection.isUserInteractionEnabled = false
        _ = self.activeCards.map({$0.flipUp()})
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            _ = self.activeCards.map({$0.flipDown()})
            self.cardsCollection.isUserInteractionEnabled = true
        })
    }
    
    private func flip(_ card: CardCell) {
        if self.currentCardHash == nil {
            card.flipUp()
            self.currentCardHash = card.getCardHash()
        } else {
            if self.currentCardHash == card.getCardHash() {
                card.flipUp()
                if !(self.activeCards.contains(where: { $0.getCardHash() == self.currentCardHash && $0.isOpen == false })) {
                    let alert = UIAlertController(title: "You won!", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.activeCards.removeAll(where: {$0.getCardHash() == self.currentCardHash})
                    self.present(alert, animated: true, completion: {})
                    self.currentCardHash = nil
                }
            } else {
                self.currentCardHash = nil
                _ = self.activeCards.map({($0 as! CardCell).flipDown()})
            }
        }
    }
    
}

//MARK: UICollectionViewDataSource
extension GameController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseId(), for: indexPath) as! CardCell
        
        cell.setData(gameData[indexPath.item])
        self.activeCards.append(cell)
        
        return cell
    }
}

//MARK: UICollecitonViewDelegateFlowLayout
extension GameController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
}

//MARK: UICollectionViewDelegate
extension GameController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let card = collectionView.cellForItem(at: indexPath) as? CardCell {
//            print("hash: \(card.flipUp())")
            flip(card)
        }
    }
}

