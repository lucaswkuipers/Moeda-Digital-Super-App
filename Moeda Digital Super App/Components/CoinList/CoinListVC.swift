//
//  TelaViewController.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 14/04/2021.
//

import UIKit
import API

class CoinListVC: UIViewController {
	
	@IBAction func getCoins(_ sender: UIButton) {
//		print(coins)
	}
	@IBOutlet var tableView: UITableView!
	
	var coins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupUI()
//		fetchData()
		print("carregou!!")
    }
	
	func setupUI() {
		
		let nib = UINib(nibName: "CoinCell", bundle: nil)
		
		tableView.register(nib, forCellReuseIdentifier: "CoinCell")
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
	}
	
	func fetchData() {
//		coins = API.requestCoinList()
	}
}

extension CoinListVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return coins.count
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as? CoinCell
		
		cell?.coinNameLabel.text = "Bitcoin!!" //coins[indexPath.row].name
						
		return  cell!
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return AppDimensions.rowHeight
	}
}

struct AppDimensions {
	static let rowHeight = CGFloat(250.0)
}