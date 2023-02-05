//
//  MarketViewController.swift
//  Market
//
//  Created by elizavetapereslavtseva 
//

import UIKit

class MarketViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let shoppingListView = ListView(frame: .zero, list: Manager.marketGroceries, listType: .Market)
        view.addSubview(shoppingListView)
        
        shoppingListView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = shoppingListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = shoppingListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = shoppingListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let heightConstraint = shoppingListView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, heightConstraint])
    }

    @IBAction func openBasket(_ sender: Any) {}
}
