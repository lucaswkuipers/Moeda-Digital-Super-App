//
//  ViewController.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 14/04/2021.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		

	}
	


}

extension UIViewController {
	static func loadFromNib() -> Self {
		func instantiateFromNib<T: UIViewController>() -> T {
			return T.init(nibName: String(describing: T.self), bundle: nil)
		}

		return instantiateFromNib()
	}
}
