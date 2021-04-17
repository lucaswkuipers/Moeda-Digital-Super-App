//
//  TelaViewController.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 14/04/2021.
//

import UIKit
import AlamofireImage
import API
import Commons
import Utilities


class CoinListVC: UIViewController {
	
	@IBOutlet var tableView: UITableView!
	@IBOutlet weak var dateLabel: UILabel!
	
	var coins: [Coin] = []
	
	// MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Moedas"
		self.navigationController?.isNavigationBarHidden = true
		setupUI()
		fetchData()
		print("Coin list loaded with a total of #\(coins.count) coins.")
    }
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = true
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		self.navigationController?.isNavigationBarHidden = false
	}
	
	func setupUI() {
		
		// Table cells
		let nib = UINib(nibName: "CoinCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: "CoinCell")
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
		
		// Date
		let currentDateTime = Date()
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "pt_br")
		formatter.dateFormat = "dd MMM yyyy"
		let date = formatter.string(from: currentDateTime)
		dateLabel.text = date.lowercased()
	}
	
	func fetchData() {
		coins = API.requestCoinList(on: self)
	}
}

// MARK: - Table View

extension CoinListVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return coins.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "CoinCell", for: indexPath) as? CoinCell
		
		let coin = coins[indexPath.row]
		let coinName = coin.name
		let coinID = coin.assetID
		
		var coinValue = "$ -"
		if let coinPriceUSD = coin.priceUsd {
			coinValue = Utilities.formatCoin(coinAmount: coinPriceUSD)
		}
		
		cell?.coinNameLabel.text = coinName
		cell?.coinIDLabel.text = coinID
		cell?.coinValueLabel.text = coinValue

		if let coinIconID = coin.idIcon {
			
			let iconID = coinIconID.replacingOccurrences(of: "-", with: "")
			let urlStr = "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_128/\(iconID).png"
			if let url = URL(string: urlStr ) {
				cell?.coinIconImageView.af.setImage(withURL: url)
			}
		}
		return cell ?? UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return AppDimensions.rowHeight
	}
}

// MARK: - Constants

struct AppDimensions {
	static let rowHeight = CGFloat(100)
}
