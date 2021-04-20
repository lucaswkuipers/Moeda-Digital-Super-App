import LucasCoinAPI

public struct DetailsViewModel {
    public var identifier: String
    public var icon: String
    public var price: Double
    public var lastHour: Double
    public var lastDay: Double
    public var lastMonth: Double
    
    
    public init(coin: Coin) {
        self.identifier = coin.assetID
        self.icon = String(coin.idIcon ?? "Icon indisponivel")
        self.price = coin.priceUsd ?? 00
        self.lastHour = coin.volume1HrsUsd
        self.lastDay = coin.volume1DayUsd
        self.lastMonth = coin.volume1MthUsd
        
    }
}
