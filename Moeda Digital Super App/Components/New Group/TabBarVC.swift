//
//  TabBarVC.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 17/04/2021.
//

import UIKit
import API

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		let tabBarVC = self
		let coinListVC = UINavigationController(rootViewController: CoinListVC())
		let favoriteListVC = UINavigationController(rootViewController: FavoriteListVC())
		favoriteListVC.title = "Adicionadas"
		
		tabBarVC.setViewControllers([coinListVC,favoriteListVC], animated: false)
		
		guard let items = tabBarVC.tabBar.items else  { return }
		
		let images = ["dollarsign.circle.fill", "star.fill"]
		for index in 0..<items.count {
			items[index].image = UIImage(systemName: images[index])
		}
	}
}

class FavoriteListVC: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .gray
		title = "Adicionadas"
		self.navigationController?.isNavigationBarHidden = true
        
        var viewController = FavoriteCollectionViewController(list: "BTC|USD|PLN")
        self.navigationController?.pushViewController(viewController, animated: true)
	}
}
