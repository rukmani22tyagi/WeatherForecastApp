
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
        carousel.type = .coverFlow2
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
        let existingType = self.type
        let alertController = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let celsius = UIAlertAction(title: "Celsius", style: .default, handler: { void in
            self.type = Temp.celsius
            if existingType != .celsius {
                DispatchQueue.main.async {
                    self.carousel.reloadData()
                }
            }
        })
        let fahrenheit = UIAlertAction(title: "Fahrenheit", style: .default, handler: { void in
            self.type = Temp.fahrenheit
            if existingType != .fahrenheit {
                DispatchQueue.main.async {
                    self.carousel.reloadData()
                }
            }
        })
        let kelvin = UIAlertAction(title: "Kelvin", style: .default, handler: { void in
            self.type = Temp.kelvin
            if existingType != .kelvin {
                DispatchQueue.main.async {
                    self.carousel.reloadData()
                }
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(celsius)
        alertController.addAction(fahrenheit)
        alertController.addAction(kelvin)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension WeatherForecastScreen: iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return forecastLists.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let forecastview = ForecastView(frame: CGRect(x: 0, y: 0, width: self.carousel.frame.width, height: self.carousel.frame.height))
        
        //set values in view
        forecastview.configureView(date: forecastLists[index].date, time: forecastLists[index].time, temp: forecastLists[index].temp, tempType: type, pressure: forecastLists[index].pressure, humidity: forecastLists[index].humidity, icon: forecastLists[index].icon)
        
        // set layer and shadow
        forecastview.setLayerShadow()
        
        return forecastview.view
    }
}
