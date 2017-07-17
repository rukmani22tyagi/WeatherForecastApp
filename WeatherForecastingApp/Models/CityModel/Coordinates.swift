
import Foundation
import ObjectMapper

class Coordinates: Mappable {
    var lat: Double?
    var long: Double?
    
    required convenience init?(map:Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lat <- map["lat"]
        long <- map["lon"]
    }
}
