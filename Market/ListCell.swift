//
//  ListCell.swift
//  Market
//
//  Created by elizavetapereslavtseva
//

import UIKit

protocol ListCellDelegate: AnyObject {
    func reloadTableView()
}

class ListCell: UITableViewCell {

    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var priceCostLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var itemView: UIImageView!
    @IBOutlet weak var weighButton: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    
    weak var delegate: ListCellDelegate?
    
    var grocery: MarketGrocery?
    static let identifier = "ListCell"
    
    @IBAction func weigh(_ sender: Any) {
        
        grocery?.weigh()
        weightLabel.isHidden = false
        setWeightLabel()
        weighButton.isHidden = true
        basketButton.isHidden = false
        updatePriceCostLabel()
    }
    
    func setWeightLabel() {
        guard let grocery = grocery, let weight = grocery.weight else { return }
        weightLabel.text = "\(weight)g"
    }
    
    @IBAction func plus(_ sender: Any) {
        resetHideWeight()
        grocery?.count += 1
        updateCount()
        checkIfCantWeigh()
        updatePriceCostLabel()
    }
    
    @IBAction func minus(_ sender: Any) {
        resetHideWeight()
        grocery?.count -= 1
        
        if let currentGrocery = grocery, currentGrocery.count < 0 {
            grocery?.count = 0
        }
        
        updateCount()
        checkIfCantWeigh()
        updatePriceCostLabel()
    }
    
    func checkIfCantWeigh() {
        guard let currentGrocery = grocery else { return }
        if !currentGrocery.canWeigh && currentGrocery.count > 0 {
            weighButton.isHidden = true
            basketButton.isHidden = false
            grocery?.calculateSingleGrocery()
        }
    }
    
    func updatePriceCostLabel() {
        guard let grocery = grocery else { return }
        priceCostLabel.text = "\(grocery.cost ?? grocery.price)₽"
    }

    
    func updateCount() {
        guard let grocery = grocery else { return }
        countLabel.text = String(grocery.count)
        weighButton.isHidden = grocery.count == 0
    }
    
    func resetHideWeight()  {
        grocery?.resetWeight()
        weightLabel.text = ""
        weightLabel.isHidden = true
        basketButton.isHidden = true
    }
    
    @IBAction func addToBasket(_ sender: Any) {
        guard var currentGrocery = grocery else { return }
        currentGrocery.id = Manager.lastId + 1
        Manager.lastId += 1
        Manager.basket.append(currentGrocery)
        grocery?.resetCount()
        updateCount()
        resetHideWeight()
        updatePriceCostLabel()
    }
    
    @IBAction func remove(_ sender: Any) {
        guard let grocery = grocery else { return }
        Manager.basket.removeAll { $0.id == grocery.id }
        delegate?.reloadTableView()
    }
}
