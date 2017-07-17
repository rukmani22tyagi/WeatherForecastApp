
import Foundation
import ObjectMapper

class JsonModel: Mappable {
    
    var city: City?
    var list: [WeatherList]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        city <- map["city"]
        list <- map["list"]
    }
}
