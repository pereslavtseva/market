//
//  BasketViewController.swift
//  Market
//
//  Created by elizavetapereslavtseva on 20.03.2022.
//

import UIKit

class BasketViewController: UIViewController, ListViewDelegate {
    
    @IBOutlet weak var purseUsingButton: UIButton!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var bonusCardLabel: UILabel!
    @IBOutlet weak var purseLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var bonusCardUsingButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    let plus = "plus.circle"
    let minus = "minus.circle"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = Manager.buyer.name
        
        Manager.isBonusCardUsing = false
        Manager.isPurseUsing = false
        
        setBalanceLabels()
        setCostLabel()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let basketListView = ListView(frame: .zero, list: Manager.basket, listType: .Basket)
        basketListView.controllerDelegate = self
        view.addSubview(basketListView)
        
        basketListView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = basketListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = basketListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = basketListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let heightConstraint = basketListView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, heightConstraint])
    }
    
    func setUsingButtons() {
        purseUsingButton.setImage(UIImage(systemName: Manager.isPurseUsing ? minus : plus), for: .normal)
        bonusCardUsingButton.setImage(UIImage(systemName: Manager.isBonusCardUsing ? minus : plus), for: .normal)
        bonusCardUsingButton.tintColor = Manager.isBonusCardUsing ? .red : .green
        purseUsingButton.tintColor = Manager.isPurseUsing ? .red : .green
        
        
    }
    
    func setBalanceLabels() {
        
        let isSufficientColor: UIColor = Manager.isEnoughMoney ? .green : .red
        purseLabel.textColor = Manager.isPurseUsing ? isSufficientColor : .black
        bonusCardLabel.textColor = Manager.isBonusCardUsing ? isSufficientColor : .black
        purseLabel.text = String(Manager.buyer.purse.balance)
        bonusCardLabel.text = String(Manager.buyer.bonusCard.balance)
    }
    
    func setPaymentButton() {
        paymentButton.isEnabled = Manager.isEnoughMoney ? true : false
    }
    
    func setCostLabel() {
        costLabel.text = String(Manager.basketGroceriesCost) + "₽"
    }
    
    func updatePaymentInfo() {
        setCostLabel()
        setBalanceLabels()
        setPaymentButton()
    }
    
    @IBAction func switchPurseUsing(_ sender: Any) {
        Manager.isPurseUsing.toggle()
        setUsingButtons()
        setBalanceLabels()
        setPaymentButton()
    }
    
    @IBAction func switchBonusCardUsing(_ sender: Any) {
        Manager.isBonusCardUsing.toggle()
        setUsingButtons()
        setBalanceLabels()
        setPaymentButton()
    }
    
    @IBAction func pay(_ sender: Any) {
        Manager.pay()
        setBalanceLabels()
        setCostLabel()
        setUsingButtons()
        setPaymentButton()
    }
}
