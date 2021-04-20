//public struct Coin {
//	public let name: String
//	public let value: Double
//
//	init(name: String, value: Double) {
//		self.name = name
//		self.value = value
//	}
//}

import Foundation

// MARK: - Coin
public struct Coin: Codable {
	public let assetID: String
	public let name: String?
	public let typeIsCrypto: Int
	public let dataStart, dataEnd, dataQuoteStart, dataQuoteEnd: String?
	public let dataOrderbookStart, dataOrderbookEnd, dataTradeStart, dataTradeEnd: String?
	public let dataSymbolsCount: Int
	public let volume1HrsUsd, volume1DayUsd, volume1MthUsd: Double
	public let priceUsd: Double?
	public let idIcon: String?

	enum CodingKeys: String, CodingKey {
		case assetID = "asset_id"
		case name
		case typeIsCrypto = "type_is_crypto"
		case dataStart = "data_start"
		case dataEnd = "data_end"
		case dataQuoteStart = "data_quote_start"
		case dataQuoteEnd = "data_quote_end"
		case dataOrderbookStart = "data_orderbook_start"
		case dataOrderbookEnd = "data_orderbook_end"
		case dataTradeStart = "data_trade_start"
		case dataTradeEnd = "data_trade_end"
		case dataSymbolsCount = "data_symbols_count"
		case volume1HrsUsd = "volume_1hrs_usd"
		case volume1DayUsd = "volume_1day_usd"
		case volume1MthUsd = "volume_1mth_usd"
		case priceUsd = "price_usd"
		case idIcon = "id_icon"
	}
}
