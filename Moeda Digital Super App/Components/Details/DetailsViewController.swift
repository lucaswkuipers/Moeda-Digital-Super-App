//
//  DetailsViewController.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 18/04/2021.
//

import UIKit
import Utilities
import API

class DetailsViewController: UIViewController {

	@IBOutlet weak var coinAssetIDLabel: UILabel!
	
	var selectedCoinAssetID = ""
	
	var coins = [Coin]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		selectedCoinAssetID = UserDefaults.standard.value(forKey: "selectedCoinAssetID") as! String
		
		fetchData()
		setupUI()
    }
	
	func setupUI() {
		let coin = coins.first
		coinAssetIDLabel.text = coin?.name
	}
	
	func fetchData() {
		coins = API.requestCoinList(on: self, assetId: selectedCoinAssetID)
	}
}
