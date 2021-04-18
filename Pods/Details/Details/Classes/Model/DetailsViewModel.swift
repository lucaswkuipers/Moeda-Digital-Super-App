import LucasCoinAPI

public struct DetailsViewModel {
    public var identifier: String
    public var icon: String
    public var price: Double
    public var lastHour: String
    public var lastMonth: String
    public var lastYear: String
    
    public init(coin: Coin) {
        self.identifier = coin.assetID
        self.icon = String(coin.idIcon ?? "D")
        self.price = coin.priceUsd ?? 00
        self.lastHour = "111"
        self.lastMonth = "1111"
        self.lastYear = "1111"
    }
}
