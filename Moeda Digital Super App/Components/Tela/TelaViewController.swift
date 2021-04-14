//
//  TelaViewController.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 14/04/2021.
//

import UIKit

class TelaViewController: UIViewController {
	
	@IBOutlet var tableView: UITableView!
	
	var coins = ["Bitcoin", "Etherium", "Dogecoin", "Dollar"]

    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupUI()
		print("carregou!!")
    }
	
	func setupUI() {
		
		let nib = UINib(nibName: "TelaTableViewCell", bundle: nil)
		
		tableView.register(nib, forCellReuseIdentifier: "TelaTableViewCell")
		tableView.delegate = self
		tableView.dataSource = self
		tableView.tableFooterView = UIView()
	}
}

extension TelaViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return coins.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TelaTableViewCell", for: indexPath) as? TelaTableViewCell
		
		cell?.nomeMoedaLabel.text = coins[indexPath.row]
						
		return  cell!
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return CGFloat(250)
	}
	

}
