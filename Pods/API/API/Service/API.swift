//
//  API.swift
//  Moeda Digital Super App
//
//  Created by Lucas Werner Kuipers on 14/04/2021.
//

import Foundation
import UIKit
import Alamofire


public class APIConstants {
	static let apiKey = "AD3C321C-D306-4391-84AD-573D38C149AB"
}

public class API {
	
	static let NetworkErrorCodes = ["400": "Bad request", "401": "Unauthorized", "403": "Forbidden", "404": "URL Not Found", "429": "Too many requests", "550": "No data"]
	
	public static func treatError(of statusCode: Int, on viewController: UIViewController) {
		print("Error! \(statusCode)")
		let code = "\(statusCode)"
	    let errorMessage = NetworkErrorCodes[code]!
		presentAlert(on: viewController, message: errorMessage)
	}
	
	public static func presentAlert(on viewController: UIViewController, message: String) {
		let alert = UIAlertController(title: "Sorry, there was an error.", message: "Error: \(message)", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
			switch action.style{
				case .default:
				print("Trying again!")
					viewController.viewDidLoad()
				case .cancel:
				print("cancel")
				
				case .destructive:
				print("destructive")
				
			@unknown default:
				print("Error")
			}
		}))
		viewController.present(alert, animated: true, completion: nil)
	}
	
	public static func retrieveData(from url: URL, to coins: [Coin]) -> [Coin] {
		var coins = coins
		print("Request OK! Retrieving data...")
		if let data = try? Data(contentsOf: url) {
			print("☑️ Success on getting data from url")
			print("URL: \(url)")

			let decoder = JSONDecoder()
			if let jsonCoins = try? decoder.decode([Coin].self, from: data) {
				print("☑️ Success on decoding json data based on [Coin].self")
				coins = jsonCoins
				print("✅ Coin list has been returned with a total of # \(coins.count) # coins")
				coins = coins.filter{$0.name != nil}
			} else {
				print("❌ Failed decoding json data based on [Coin].self")
				print("data: \(data)")
			}
		} else {
		print("❌ Failed getting data from url")
		print("url: \(url)")
		}
		return coins
	}
	
	// Sync
	public static func requestCoinList(on viewController: UIViewController, assetId: String = "") -> [Coin] {
		print("-- Initiating request for the coins list --")

		var coins = [Coin]()
		let urlString = "https://rest.coinapi.io/v1/assets/\(assetId)?apikey=\(APIConstants.apiKey)"

		if let url = URL(string: urlString) {
			print("☑️ Success on converting urlString to URL")

			let response = URLSession.shared.synchronousDataTask(with: url)

			if let httpResponse = response as? HTTPURLResponse {
				
				let statusCode = httpResponse.statusCode
				print("statusCode: \(statusCode)")

				if statusCode == 200 {
					coins = retrieveData(from: url, to: coins)
				} else {
					treatError(of: statusCode, on: viewController)
				}
			}
		} else {
			print("❌ Failed converting urlString to URL")
			print("urlString: \(urlString)")
		}
		print("-- Finished request for coins list --")
		return coins
	}
	
// MARK: - Async
//	public static func requestCoinList(assetId: String = "") -> [Coin] {
//		print("-- Initiating request for the coins list --")
//
//		var coins = [Coin]()
//		let urlString = "https://rest.coinapi.io/v1/assets/\(assetId)?apikey=\(APIConstants.apiKey)"
//
//		if let url = URL(string: urlString) {
//			print("☑️ Success on converting urlString to URL")
//
//			let request = URLRequest(url: url)
//
//			let task = URLSession.shared.dataTask(with: request) {data, response, error in
//
//				if let httpResponse = response as? HTTPURLResponse {
//
//					let statusCode = httpResponse.statusCode
//					print("statusCode: \(statusCode)")
//
//					if statusCode == 200 {
//						coins = retrieveData(from: url, to: coins)
//					} else {
//						treatError(of: statusCode)
//					}
//				}
//			}
//			task.resume()
//		} else {
//			print("❌ Failed converting urlString to URL")
//			print("urlString: \(urlString)")
//		}
//		print("-- Finished request for coins list --")
//		return coins
//	}
}

public func print(_ coins: [Coin]) {
	let names = coins.map{$0.name!}
	for name in names {
		print(name)
	}
}

extension URLSession {
	func synchronousDataTask(with url: URL) -> (URLResponse?) {
		var data: Data?
		var response: URLResponse?
		var error: Error?

		let semaphore = DispatchSemaphore(value: 0)

		let dataTask = self.dataTask(with: url) {
			data = $0
			response = $1
			error = $2

			semaphore.signal()
		}
		dataTask.resume()

		_ = semaphore.wait(timeout: .distantFuture)
		
		return (response)
	}
}
//
//extension URLResponse {
//
//	func getStatusCode() -> Int? {
//		if let httpResponse = self as? HTTPURLResponse {
//			return httpResponse.statusCode
//		}
//		return nil
//	}
//}

//if let statusCode = urlResponse.getStatusCode() { /*...*/ }



// MARK: - Working
//public class API {
//
//	public static func requestCoinList(assetId: String = "") -> [Coin] {
//		print("-- Initiating request for the coins list --")
//
//		var coins = [Coin]()
//		let urlString = "https://rest.coinapi.io/v1/assets/\(assetId)?apikey=\(APIConstants.apiKey)"
//
//		if let url = URL(string: urlString) {
//			print("☑️ Success on converting urlString to URL")
//
//			if let data = try? Data(contentsOf: url) {
//				print("☑️ Success on getting data from url")
//				print("URL: \(url)")
//
//				let decoder = JSONDecoder()
//				if let jsonCoins = try? decoder.decode([Coin].self, from: data) {
//					print("☑️ Success on decoding json data based on [Coin].self")
//					coins = jsonCoins
//					print("✅ Coin list has been returned with a total of # \(coins.count) # coins")
////					print(coins)
//					return coins.filter{$0.name != nil}
//				} else {
//					print("❌ Failed decoding json data based on [Coin].self")
//					print("data: \(data)")
//				}
//			} else {
//				print("❌ Failed getting data from url")
//				print("url: \(url)")
//			}
//		} else {
//			print("❌ Failed converting urlString to URL")
//			print("urlString: \(urlString)")
//		}
//		print("-- Finished request for coins list --")
//		return coins
//	}
//}
