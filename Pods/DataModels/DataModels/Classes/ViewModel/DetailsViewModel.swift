
public struct DetailsViewModel {
    public var identifier: String
    public var icon: String
    public var price: Double
    public var lastHour: Double
    public var lastMonth: Double
    public var lastYear: Double
    
    public init(identifier: String, icon: String, price: Double, lastHour: Double, lastMonth: Double, lastYear: Double) {
        self.identifier = identifier
        self.icon = icon
        self.price = price
        self.lastHour = lastHour
        self.lastMonth = lastMonth
        self.lastYear = lastYear
    }
}
