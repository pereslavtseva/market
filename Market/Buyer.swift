//
//  Buyer.swift
//  Market
//
//  Created by elizavetapereslavtseva 
//

import Foundation

enum ListType {
    case Market, Basket
}
enum Grocery {
    case Milk, Meat, Curd, Cucumber, Tomato, Apple, Banana, Cabbage
}

struct MarketGrocery {
    
    var id: Int?
    var name: Grocery
    var price: Double
    var image: String
    var unitWeight: Int?
    var unitWeightRange: ClosedRange<Int>?
    var weight: Int?
    var count: Int = 0
    var cost: Double?
    var canWeigh: Bool
    
    mutating func weigh() {
        //count = count ?? 1
        guard let unitWeightRange = unitWeightRange else { return }
        weight = count * (unitWeightRange.randomElement() ?? 0)
        guard let weight = weight else { return }
        cost = (price * Double(weight) / 100).reduced()
    }
    
    mutating func calculateSingleGrocery() {
        cost = (Double(count) * price).reduced()
        guard let unitWeight = unitWeight else { return }
        weight = count * unitWeight
    }
    
    mutating func resetWeight() {
        weight = nil
        cost = nil
    }
    
    mutating func resetCount() {
        count = 0
        resetWeight()
    }
    
}


struct Purse {
    var balance: Double
}

struct BonusCard {
    var balance: Double
}

struct Buyer {
    var name: String
    var purse: Purse
    var bonusCard: BonusCard
    var shoppingList: [MarketGrocery]
}
