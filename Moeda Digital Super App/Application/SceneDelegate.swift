//
//  SceneDelegate.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 14/04/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	@available(iOS 13.0, *)
	func sceneDidEnterBackground(_ scene: UIScene) {
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}


}

