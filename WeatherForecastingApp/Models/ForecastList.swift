
import Foundation

class ForecastList {
    var date: String
    var time: String
    var icon: String
    var temp: Double
    var pressure: Double
    var humidity: Int
    
    init(_date: String, _time: String, _icon: String, _temp: Double, _pressure: Double, _humidity: Int) {
        self.date = _date
        self.time = _time
        self.icon = _icon
        self.temp = _temp
        self.pressure = _pressure
        self.humidity = _humidity
    }
}
