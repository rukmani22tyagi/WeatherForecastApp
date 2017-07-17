
import UIKit

class ForecastView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var forecastView: UIView!
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("View", owner: self, options: nil)
        
        self.addSubview(self.view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // set layer and shadow
    func setLayerShadow() {
        self.forecastView.layer.cornerRadius = 2.0
        self.forecastView.layer.shadowColor = UIColor.white.cgColor
        self.forecastView.layer.shadowRadius = 5.0
        self.forecastView.layer.shadowOpacity = 1
        self.forecastView.layer.shadowOffset = CGSize(width: 5,height: 5)
    }
    
    //set values in view
    func configureView(date: String, time: String, temp: Double, tempType: Temp, pressure: Double, humidity: Int, icon: String) {
        self.dateLabel.text = "\(date)"
        self.timeLabel.text = "\(time)"
        switch tempType {
            case .celsius: self.tempLabel.text = "Temperature: \(temp - 273) °C"
            case .fahrenheit: let tempInF = ((9 * (temp - 273)) / 5) + 32
                self.tempLabel.text = "Temperature: \(tempInF) °F"
            case .kelvin: self.tempLabel.text = "Temperature: \(temp) K"
        }
        self.pressureLabel.text = "Pressure: \(pressure)"
        self.humidityLabel.text = "Humidity: \(humidity)"
        
        let url = URL(string: "\(weatherIconURL)\(icon)\(weatherIconURLAddon)")!
        DispatchQueue.main.async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.global().sync {
                    self.imageView.image = UIImage(data: data)
                }
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
    }
}
