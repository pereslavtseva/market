//
//  Manager.swift
//  Market
//
//  Created by elizavetapereslavtseva on 20.03.2022.
//

import Foundation

extension Double {
    func reduced() -> Double {
        Double(Int(self * 100))/100
    }
}

class Manager {
    
    static var lastId = 0
    
    static var basket = [MarketGrocery]()
    
    static var basketGroceriesCost: Double {
        basket.compactMap({ $0.cost }).reduce(0, +).reduced()
    }
    
    static var isPurseUsing = false
    static var isBonusCardUsing = false
    static var availablePurseFunds: Double {
        isPurseUsing ? buyer.purse.balance : 0
    }
    
    static var availableBonusCardFunds: Double {
        isBonusCardUsing ? buyer.bonusCard.balance : 0
    }
    
    static var isEnoughMoney: Bool {
        availablePurseFunds + availableBonusCardFunds > basketGroceriesCost
    }
    
    static let cabbage = MarketGrocery(name: .Cabbage, price: 110, image: "cabbage", unitWeightRange: 30...50, canWeigh: true)
    static let apple = MarketGrocery(name: .Apple, price: 80, image: "apple", unitWeightRange: 30...50, canWeigh: true)
    static let banana = MarketGrocery(name: .Banana, price: 120, image: "banana", unitWeightRange: 30...50, canWeigh: true)
    static let cucumber = MarketGrocery(name: .Cucumber, price: 90, image: "cucumber", unitWeightRange: 30...50, canWeigh: true)
    static let meat = MarketGrocery(name: .Meat, price: 130, image: "meat", unitWeightRange: 30...50, canWeigh: true)
    static let milk = MarketGrocery(name: .Milk, price: 100, image: "milk", unitWeight: 1000, canWeigh: false)
    static let curd = MarketGrocery(name: .Curd, price: 70, image: "curd", unitWeightRange: 30...50, canWeigh: true)
    static let tomato = MarketGrocery(name: .Tomato, price: 100, image: "tomato", unitWeightRange: 30...50, canWeigh: true)


    static var buyer = Buyer(name: "Лиза", purse: Purse(balance: 1000), bonusCard: BonusCard(balance: 500), shoppingList: [banana, apple, cabbage])

    static let marketGroceries = [cabbage, apple, tomato, banana, cucumber, meat, milk, curd]

    static func pay() {
        
        var cost = basketGroceriesCost
        
        if availableBonusCardFunds >= cost {
            buyer.bonusCard.balance -= cost
            cost = 0
        } else if isBonusCardUsing {
            cost -= buyer.bonusCard.balance
            buyer.bonusCard.balance = 0
        }
        
        if isPurseUsing {
            buyer.purse.balance -= cost
            cost = 0
        }
        
        basket.removeAll()
        isPurseUsing = false
        isBonusCardUsing = false
    }
}
