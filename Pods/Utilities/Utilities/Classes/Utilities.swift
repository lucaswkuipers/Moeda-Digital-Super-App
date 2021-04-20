//
//  Utilities.swift
//  Pods-ExampleUtilities
//
//  Created by Lucas Werner Kuipers on 15/04/2021.
//

import Foundation

public class Utilities {
	
	public static func formatCoin(coinAmount: Double) -> String {
		
		let roundedAmount = "\(coinAmount.rounded(toPlaces: 2))"
		let moneyParts = roundedAmount.components(separatedBy: ".")
		let integerPart = moneyParts.first
		let decimalPart = moneyParts.last
		
		
		let groupSize = 3
		var thousands = [String]()
		
		let str = integerPart!
		
		for i in stride(from: 0, to: str.count, by: groupSize) {
			let endIndex = str.index(str.endIndex, offsetBy: -i)
			let startIndex = str.index(endIndex, offsetBy: -groupSize, limitedBy: str.startIndex) ?? str.startIndex
				thousands.insert(String(str[startIndex..<endIndex]), at: 0)
		}
		
		let formattedMoney = "$ \(thousands.joined(separator: ",")).\(decimalPart!)"
		return formattedMoney
	}
	
	public static func encode(idList: [String]) -> String {
		
		let encoded = idList.joined(separator: "|")
		print("ID list encoded to string: \(encoded)")
		return encoded
	}
	
	public static func decode(idListString: String) -> [String] {
		
		let decoded = idListString.components(separatedBy: "|")
		print("String of ID List decoded to array of string: \(decoded)")
		return decoded
	}
}

extension Double {
	/// Rounds the double to decimal places value
	func rounded(toPlaces places:Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}
