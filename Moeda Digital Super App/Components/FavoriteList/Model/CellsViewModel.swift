import API

public struct CellsViewModel{
    
    public var icon: String
    public var name: String
    public var identifier: String
    public var price: Double
    
    
    public init(coin: Coin) {
        self.icon = String(coin.idIcon ?? " ")
        self.name = coin.name ?? "indisponivel"
        self.identifier = coin.assetID
        self.price = coin.priceUsd ?? 00
        
    }
}
