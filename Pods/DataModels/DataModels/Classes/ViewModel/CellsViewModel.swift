
public struct CellsViewModel{
    
    public var icon: String
    public var name: String
    public var identifier: String
    public var price: Double
    
    
    public init(icon: String, name: String, identifier: String, price: Double) {
        self.icon = icon
        self.name = name
        self.identifier = identifier
        self.price = price
        
    }
}
