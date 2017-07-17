
import Foundation
import ObjectMapper

class Main: Mappable {
    var temp: Double?
    var pressure: Double?
    var humidity: Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        temp <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
    }
}
