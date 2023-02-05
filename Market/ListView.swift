//
//  ListView.swift
//  Market
//
//  Created by elizavetapereslavtseva 
//

import UIKit

protocol ListViewDelegate: AnyObject{
    func updatePaymentInfo()
}

class ListView: UITableView, UITableViewDelegate, UITableViewDataSource, ListCellDelegate {
    
    var list: [MarketGrocery]
    var listType: ListType
    
    weak var controllerDelegate: ListViewDelegate?
    
    init(frame: CGRect, list: [MarketGrocery], listType: ListType) {
        self.list = list
        self.listType = listType
        super.init(frame: frame, style: .plain)
        allowsSelection = false
        register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listType == .Basket ? Manager.basket.count : list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as? ListCell
        cell?.delegate = self
        
        let currentList = listType == .Basket ? Manager.basket : list
        let grocery = currentList[indexPath.row]
        
        cell?.grocery = grocery
        
        cell?.itemLabel.text = "\(grocery.name)"
        cell?.itemView.image = UIImage(named: grocery.image)
        cell?.updatePriceCostLabel()
        cell?.countLabel.text = "\(grocery.count)"
        
        let contains = Manager.buyer.shoppingList.map({$0.name}).contains(grocery.name)
        
        cell?.backgroundColor = contains ? UIColor(named: "pink") : UIColor(named: "blue")
        
        switch listType {
        case .Market:
            cell?.minusButton.isHidden = false
            cell?.plusButton.isHidden = false
            cell?.weightLabel.isHidden = true
            cell?.trashButton.isHidden = true
        case .Basket:
            cell?.minusButton.isHidden = true
            cell?.plusButton.isHidden = true
            cell?.weightLabel.isHidden = false
            cell?.trashButton.isHidden = false
            cell?.setWeightLabel()
        }
        
        return cell ?? UITableViewCell()
    }
    
    func reloadTableView() {
        reloadData()
        controllerDelegate?.updatePaymentInfo()
    }
}
