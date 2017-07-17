
import Foundation
import Alamofire
import ObjectMapper

class Controller {

    var mappedObject: JsonModel?
    
    func downLoadWeatherForecast(complete: @escaping DownloadComplete) {
        let url = forecastURL + "\(Location.sharedInstance.latitude)" + forecastURLAddon + "\(Location.sharedInstance.longitude)" + forecastURLEnd
        print(url)
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let json) :
                let mapped = Mapper<JsonModel>().map(JSONObject: json)
                self.mappedObject = mapped
            case .failure(let err) :
                print(err.localizedDescription)
            }
            complete(self.mappedObject!)
        }
    }
}
