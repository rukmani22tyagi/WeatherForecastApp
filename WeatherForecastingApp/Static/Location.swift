
import Foundation

class Location {
    
    static let sharedInstance = Location()
    
    private init() { }
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}
