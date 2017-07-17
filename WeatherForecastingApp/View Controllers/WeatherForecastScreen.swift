
import UIKit
import iCarousel

enum Temp {
    case celsius
    case kelvin
    case fahrenheit
}

class WeatherForecastScreen: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var carousel: iCarousel!
    
    var controller = Controller()
    var forecastLists = [ForecastList]()
    let forecastView = ForecastView()
    var type = Temp.kelvin
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carousel.type = .invertedRotary
        carousel.scrollSpeed = 1.0
        controller.downLoadWeatherForecast(complete: { mappedObject in
            self.updateUI(mappedObject)
        })
    }
    
    func updateUI(_ mappedObject: JsonModel?) {
        if let _ = mappedObject {
            self.cityLabel.text = mappedObject?.city?.name
            self.country.text = "Country : \((mappedObject?.city?.country)!)"
            self.latitude.text = "Latitude : \((mappedObject?.city?.coordinates?.lat)!)"
            self.longitude.text = "Longitude : \((mappedObject?.city?.coordinates?.long)!)"
            
            for list in (mappedObject?.list)! {
                var date = ""
                var time = ""
                if let dt = list.dt {
                    let unixConvertedDate = Date(timeIntervalSince1970: dt)
                    date = unixConvertedDate.getDate()
                }
                if let tm = list.dt {
                    let unixConvertedDate = Date(timeIntervalSince1970: tm)
                    time = unixConvertedDate.getTime()
                }
                let forecast = ForecastList(_date: date, _time: time, _icon: (list.weather?.first?.icon)!, _temp: ((list.main?.temp)!), _pressure: (list.main?.pressure)!, _humidity: (list.main?.humidity)!)
                forecastLists.append(forecast)
            }
        }
        DispatchQueue.main.async {
            self.carousel.reloadData()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func settingButtonTapped(_ sender: Any) {
        showAlertForTemp(msg: "Choose Temperature Format")
    }
}

extension WeatherForecastScreen {
    func showAlertForTemp(msg: String) {
        let alertController = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let celsius = UIAlertAction(title: "Celsius", style: .default, handler: { void in
            self.type = Temp.celsius
            DispatchQueue.main.async {
                self.carousel.reloadData()
            }
        })
        let fahrenheit = UIAlertAction(title: "Fahrenheit", style: .default, handler: { void in
            self.type = Temp.fahrenheit
            DispatchQueue.main.async {
                self.carousel.reloadData()
            }
        })
        let kelvin = UIAlertAction(title: "Kelvin", style: .default, handler: { void in
            self.type = Temp.kelvin
            DispatchQueue.main.async {
                self.carousel.reloadData()
            }
        })
        alertController.addAction(celsius)
        alertController.addAction(fahrenheit)
        alertController.addAction(kelvin)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension WeatherForecastScreen: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return forecastLists.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let forecastview = ForecastView(frame: CGRect(x: 0, y: self.headerView.frame.maxY, width: 300, height: 300))
        
        //set values in view
        forecastview.configureView(date: forecastLists[index].date, time: forecastLists[index].time, temp: forecastLists[index].temp, tempType: type, pressure: forecastLists[index].pressure, humidity: forecastLists[index].humidity, icon: forecastLists[index].icon)
        
        // set layer and shadow
        forecastview.setLayerShadow()
        
        return forecastview.view
    }
}
