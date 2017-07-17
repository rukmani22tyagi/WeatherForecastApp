
import Foundation
import ObjectMapper

class Weather: Mappable {
    var id: Int?
    var icon: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        icon <- map["icon"]
    }
}
