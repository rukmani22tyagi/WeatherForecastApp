
import Foundation
import ObjectMapper

class WeatherList: Mappable {
    var dt: Double?
    var main: Main?
    var weather: [Weather]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        dt <- map["dt"]
        main <- map["main"]
        weather <- map["weather"]
    }
}
