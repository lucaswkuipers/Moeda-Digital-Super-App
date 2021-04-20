//
//  TabBarVC.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 17/04/2021.
//

import UIKit
import API

class TabBarVC: UITabBarController {

	var allCoins = [Coin]()
	
	func fetchData() {
		allCoins = API.requestCoinList(on: self)
	}
	
	func verifyUserDefaults() {
		if UserDefaults.standard.value(forKey: "favoriteList") == nil {
			UserDefaults.standard.setValue("", forKey: "favoriteList")
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		fetchData()
		verifyUserDefaults()
    }
	
	func setupTabs() {
		let tabBarVC = self
		let coinListVC = UINavigationController(rootViewController: CoinListVC(allCoins: allCoins))
		let favoriteListVC = UINavigationController(rootViewController: FavoriteViewController(allCoins: allCoins))
		favoriteListVC.title = "Adicionadas"
		
		tabBarVC.setViewControllers([coinListVC,favoriteListVC], animated: false)
		
		guard let items = tabBarVC.tabBar.items else  { return }
		
		let images = ["dollarsign.circle.fill", "star.fill"]
		for index in 0..<items.count {
			items[index].image = UIImage(systemName: images[index])
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		setupTabs()
	}
}

//class FavoriteListVC: UIViewController {
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		view.backgroundColor = .gray
//		title = "Adicionadas"
//		self.navigationController?.isNavigationBarHidden = true
//
//        let viewController = FavoriteViewController()
//        self.navigationController?.pushViewController(viewController, animated: true)
//	}
//}
