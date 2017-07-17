
import Foundation
import ObjectMapper

class City: Mappable {
    
    var name: String?
    var coordinates: Coordinates?
    var country: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        coordinates <- map["coord"]
        country <- map["country"]
    }
}
