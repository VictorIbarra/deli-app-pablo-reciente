class DeliveryCostResponse: Codable {
    var success: Int?
    var cost: Double?
    var message: String?
    
    init(success: Int?, cost: Double?, message: String?) {
        self.success = success
        self.cost = cost
        self.message = message
    }
}
