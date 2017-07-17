
import Foundation

typealias DownloadComplete = (JsonModel?) -> ()

let apiKey = "82d316e8e5b1aaac532f77fea9e766b4"

let forecastURL = "http://api.openweathermap.org/data/2.5/forecast?lat="
let forecastURLAddon = "&lon="
let forecastURLEnd = "&appid=\(apiKey)"

let weatherIconURL = "https://openweathermap.org/img/w/"
let weatherIconURLAddon = ".png"
