import UIKit
import RealmSwift

class WeatherViewController: UIViewController {
    @IBOutlet weak var currTempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var weatherView: UIView!
    
    var weatherService = URLSessionWeatherService()
    @IBOutlet weak var dataTable: UITableView!
    
    var arrDays: [String] = []
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allCurrentWeather = realm.objects(RealmCurrentWeather.self)
        let forecast = realm.objects(RealmForecast.self)
        createArrOfDays()
        creatingBoofCurrentWeatherRealm(all: allCurrentWeather)
        creatingBoofForecastRealm(all: forecast)
        prevLoadTable(all: forecast)
        labelsUpdate(weather: allCurrentWeather[0])
        weatherService.loadForecast(completion: { result in
            switch result {
            case .success(let f):
                self.weatherService.arrForecast = f
                DispatchQueue.main.async {
                    try! self.realm.write {
                        for (index, i) in forecast.enumerated() {
                            i.tempDay = f.daily[index].temp.day
                            i.tempNight = f.daily[index].temp.night
                            i.weather = f.daily[index].weather[0].main
                        }
                    }
                    self.dataTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        weatherService.loadCurrentWeather(completion: { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    try! self.realm.write {
                        allCurrentWeather[0].temp = String(Int(weather.main.temp - 273.15)) + "C°"
                        allCurrentWeather[0].main = weather.weather[0].main
                        allCurrentWeather[0].feelsTemp = "Feels like: " + String(Int(weather.main.feelsLike - 273.15)) + "C°"
                        allCurrentWeather[0].weatherDescription = "Weather description: " + weather.weather[0].description
                        allCurrentWeather[0].humidity = "Humidity: " + String(weather.main.humidity) + "%"
                        allCurrentWeather[0].pressure = "Pressure: " + String(round(Double(weather.main.pressure) / 1.333223 * 10) / 10) + "mmHg"
                    }
                    self.labelsUpdate(weather: allCurrentWeather[0])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func prevLoadTable(all: Results<RealmForecast>) {
        var z: [Day] = [Day(dt: 0, weather: [Weather(main: all[0].weather)], temp: Temp(day: all[0].tempDay, night: all[0].tempNight))]
        for i in 1 ..< 8 {
            z.append(Day(dt: 0, weather: [Weather(main: all[i].weather)], temp: Temp(day: all[i].tempDay, night: all[i].tempNight)))
        }
        weatherService.arrForecast = Forecast(daily: z)
    }
    
    
    func createArrOfDays() {
        let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        let date = Date()
        let calendar = Calendar.current
        let today = calendar.component(.weekday, from: date)
        arrDays = Array(days[today ..< today + 7])
    }
    
    func creatingBoofCurrentWeatherRealm(all: Results<RealmCurrentWeather>) {
        if all.count > 0 { return }
        let object = RealmCurrentWeather()
        try! realm.write {
            realm.add(object)
        }
    }
    
    func creatingBoofForecastRealm(all: Results<RealmForecast>) {
        if all.count > 7 { return }
        try! realm.write {
            for _ in 0 ..< 8 {
                let object = RealmForecast()
                realm.add(object)
            }
        }
    }
    
    func labelsUpdate(weather: RealmCurrentWeather) {
        currTempLabel.text = weather.temp
        weatherLabel.text = weather.main
        feelsLikeTempLabel.text! = weather.feelsTemp
        weatherDescriptionLabel.text! = weather.weatherDescription
        humidityLabel.text! = weather.humidity
        pressureLabel.text! = weather.pressure
    }
}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecast") as! DefaultForecastTableViewCell
        cell.dayLabel.text = arrDays[indexPath.row]
        cell.weatherLabel.text = weatherService.arrForecast?.daily[indexPath.row + 1].weather[0].main
        cell.tempDayLabel.text = String(Int((weatherService.arrForecast?.daily[indexPath.row + 1].temp.day ?? -999) - 273.15))
        cell.tempNightLabel.text = String(Int((weatherService.arrForecast?.daily[indexPath.row + 1].temp.night ?? -999) - 273.15))
        return cell
    }
}
