# TIL
#####################################################################################2021.09.04_1
Double+Formatter
import Foundation

fileprivate let temperatureFormatter: MeasurementFormatter = {
    let f = MeasurementFormatter()
    f.locale = Locale(identifier: "ko_kr")
    f.numberFormatter.maximumFractionDigits = 1
    f.unitOptions = .temperatureWithoutUnit
    return f
    
}()

extension Double {
    var temperatureString: String {
        let temp = Measurement<UnitTemperature>(value: self, unit: .celsius)
        return temperatureFormatter.string(from: temp)
    }
}

#####################################################################################2021.09.04
import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = CLLocation(latitude: 37.498206, longitude: 127.02716)
        WeatherDataSource.shared.fetch(location: location) {
            self.listTableView.reloadData()
        }
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            
            if let weather = WeatherDataSource.shared.summary?.weather.first, let main = WeatherDataSource.shared.summary?.main {
                cell.weatherImageView.image = UIImage(named: weather.icon)
                cell.StatusLabel.text = weather.description
                cell.minMaxLabel.text = "최고 \(main.temp_max.temperatureString) 최소 \(main.temp_min.temperatureString)"
                cell.currentTemperatureLabel.text = "\(main.temp.temperatureString)"
            }
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTabelViewCell
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}


#####################################################################################2021.09.03
Step15. 현재 날씨 출력
Step16. 예보출력

#####################################################################################2021.09.02_2
Step14. 날씨 데이터 소스 구현
import Foundation
import CoreLocation

class WeatherDataSource {
    static let shared = WeatherDataSource()
    private init() { }
    
    var summary: CurrentWeather?
    var forecast: Forecast?
    
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent)
    
    let group = DispatchGroup()
    
    func fetch(location: CLLocation, completion: @escaping () -> ()) {
        group.enter()
        apiQueue.async {
            self.fetchCurrentWeather(location: location) { (result) in
                switch result {
                case .success(let data):
                    self.summary = data
                default:
                    self.summary = nil
                }
                
                self.group.leave()
            }
        }
        
        group.enter()
        apiQueue.async {
            self.fetchForecast(location: location) { (result) in
                switch result {
                case .success(let data):
                    self.forecast = data
                default:
                    self.forecast = nil
                }
                
                self.group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
}


extension WeatherDataSource {
    private func fetch<ParsingType: Codable>(urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()) {
    guard let url = URL(string: urlStr) else {
        //fatalError("URL 생성 실패")
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data,response, error) in

        if let error = error {
            //fatalError(error.localizedDescription)
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            //fatalError("invalid response")
            completion(.failure(ApiError.invalidResponse))
            return
        }

        guard httpResponse.statusCode == 200 else {
            //fatalError("failed code \(httpResponse.statusCode)")
            completion(.failure(ApiError.failed(httpResponse.statusCode)))
            return
        }

        guard let data = data else {
            //fatalError("empty data")
            completion(.failure(ApiError.emptyData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ParsingType.self, from: data)
            
            completion(.success(data))
           
        } catch {
            completion(.failure(error))
            //print(error)
            //fatalError(error.localizedDescription)
            }

        }
    task.resume()

    }
   private func fetchCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
        
    }

    private func fetchCurrentWeather(cityId: Int, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
    }

    private func fetchCurrentWeather(location: CLLocation, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
    }
}


extension WeatherDataSource {
   private func fetchForecast(cityName: String, completion: @escaping (Result<Forecast,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
        
    }

   private func fetchForecast(cityId: Int, completion: @escaping (Result<Forecast,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
    }

   private func fetchForecast(location: CLLocation, completion: @escaping (Result<Forecast,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
    }
}



#####################################################################################2021.09.02_1
Step13. 예보 API#2
import UIKit
import CoreLocation

struct Forecast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    
    struct ListItem: Codable {
        let dt: Int
        struct Main: Codable {
            let temp: Double
        }
        
        let main: Main
        
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        let weather: [Weather]
    }
    
    let list: [ListItem]
    
}


enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}

func fetch<ParsingType: Codable>(urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()) {
    guard let url = URL(string: urlStr) else {
        //fatalError("URL 생성 실패")
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data,response, error) in

        if let error = error {
            //fatalError(error.localizedDescription)
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            //fatalError("invalid response")
            completion(.failure(ApiError.invalidResponse))
            return
        }

        guard httpResponse.statusCode == 200 else {
            //fatalError("failed code \(httpResponse.statusCode)")
            completion(.failure(ApiError.failed(httpResponse.statusCode)))
            return
        }

        guard let data = data else {
            //fatalError("empty data")
            completion(.failure(ApiError.emptyData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ParsingType.self, from: data)
            
            completion(.success(data))
           
        } catch {
            completion(.failure(error))
            //print(error)
            //fatalError(error.localizedDescription)
        }

    }
    task.resume()

}
//opt + comm + F = replace(찾아바꾸기)

func fetchForecast(cityName: String, completion: @escaping (Result<Forecast,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
    
}

func fetchForecast(cityId: Int, completion: @escaping (Result<Forecast,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
}

func fetchForecast(location: CLLocation, completion: @escaping (Result<Forecast,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
}

let location = CLLocation(latitude: 37.498206, longitude: 127.02761)
fetchForecast(location: location) { (result) in
    switch result {
    case .success(let weather):
        dump(weather)
    case .failure(let error):
        print(error)
    }
}


//fetchForecast(cityName: "seoul") { _ in }
//
//
//fetchForecast(cityId: 1835847) { (result) in
//    switch result {
//    case .success(let weather):
//        dump(weather)
//    case .failure(let error):
//        print(error)
//    }
//}



#####################################################################################2021.09.02
Step11. 현재날씨 API#2
import UIKit
import CoreLocation
struct CurrentWeather: Codable {
    let dt: Int
    
    struct  Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    let main: Main
}

enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}

func fetch<ParsingType: Codable>(urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()) {
    guard let url = URL(string: urlStr) else {
        //fatalError("URL 생성 실패")
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data,response, error) in

        if let error = error {
            //fatalError(error.localizedDescription)
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            //fatalError("invalid response")
            completion(.failure(ApiError.invalidResponse))
            return
        }

        guard httpResponse.statusCode == 200 else {
            //fatalError("failed code \(httpResponse.statusCode)")
            completion(.failure(ApiError.failed(httpResponse.statusCode)))
            return
        }

        guard let data = data else {
            //fatalError("empty data")
            completion(.failure(ApiError.emptyData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ParsingType.self, from: data)
            
            completion(.success(data))
           
        } catch {
            completion(.failure(error))
            //print(error)
            //fatalError(error.localizedDescription)
        }

    }
    task.resume()

}

func fetchCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
    
}

func fetchCurrentWeather(cityId: Int, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
}

func fetchCurrentWeather(location: CLLocation, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
}

let location = CLLocation(latitude: 37.498206, longitude: 127.02761)
fetchCurrentWeather(location: location) { (result) in
    switch result {
    case .success(let weather):
        dump(weather)
    case .failure(let error):
        print(error)
    }
}


//fetchCurrentWeather(cityName: "seoul") { _ in }
//
//
//fetchCurrentWeather(cityId: 1835847) { (result) in
//    switch result {
//    case .success(let weather):
//        dump(weather)
//    case .failure(let error):
//        print(error)
//    }
//}
#####################################################################################2021.09.01
step by step_Weather App
현재날씨 Api#2

#####################################################################################2021.08.31_1
import UIKit

struct CurrentWeather: Codable {
    let dt: Int
    
    struct  Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    let main: Main
}

func fetchCurrentWeather(cityName: String) {
    let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    guard let url = URL(string: urlStr) else {
        fatalError("URL 생성 실패")
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data,response, error) in
        
        if let error = error {
            fatalError(error.localizedDescription)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            fatalError("invalid response")
        }
        
        guard httpResponse.statusCode == 200 else {
            fatalError("failed code \(httpResponse.statusCode)")
        }
        
        guard let data = data else {
            fatalError("empty data")
        }
        
        do {
            let decoder = JSONDecoder()
            let weather = try decoder.decode(CurrentWeather.self, from: data)
            
            weather.weather.first?.description
            
            weather.main.temp
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
        
    }
    task.resume()
}

fetchCurrentWeather(cityName: "seoul")

#####################################################################################2021.08.31
_JSON
{
    "coord": {
        "lon": 126.9778,
        "lat": 37.5683
    },
    "weather": [
        {
            "id": 501,
            "main": "Rain",
            "description": "보통 비",
            "icon": "10n"
        },
        {
            "id": 701,
            "main": "Mist",
            "description": "박무",
            "icon": "50n"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 18.75,
        "feels_like": 19.13,
        "temp_min": 18.66,
        "temp_max": 19.71,
        "pressure": 1011,
        "humidity": 94
    },
    "visibility": 5000,
    "wind": {
        "speed": 3.09,
        "deg": 10
    },
    "rain": {
        "1h": 0.51
    },
    "clouds": {
        "all": 90
    },
    "dt": 1630420368,
    "sys": {
        "type": 1,
        "id": 8105,
        "country": "KR",
        "sunrise": 1630357285,
        "sunset": 1630404241
    },
    "timezone": 32400,
    "id": 1835848,
    "name": "Seoul",
    "cod": 200
}
#####################################################################################2021.08.30_3
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTabelViewCell
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

#####################################################################################2021.08.30_2
ForecastTableViewCell
import UIKit

class ForecastTabelViewCell: UITableViewCell {

    static let identifier = "ForecastTableViewCell"
    
    @IBOutlet weak var dateLable: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var weaterImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Inatialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

#####################################################################################2021.08.30
SummaryTableViewCell
import UIKit

class SummaryTableViewCell: UITableViewCell {

    static let identifier = "SummaryTableViewCell"
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var StatusLabel: UILabel!
    
    @IBOutlet weak var minMaxLabel: UILabel!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

#####################################################################################2021.08.29
//섭씨로 변경, units = metric
//언어 변경, lang = kr

//이미지_icon다운로드 https://www.flaticon.com/free-icon/sun_861059

//아이콘이미지로변경 https://makeappicon.com(오류)

//앱 배경화면은 투명사용 불가, 불투명한 색을 사용해야 한다.

#####################################################################################2021.08.28_2
Weather API
//https://openweathermap.org
//songgyeol@kakao.com / song167855 / IOS
//weather dater code :7321aa59b6ca9072137e5b4b951757aa
let apikey = "7321aa59b6ca9072137e5b4b951757aa"


#####################################################################################2021.08.28
KXCWeatherApp
import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
#####################################################################################2021.08.27
2021.08.27
Mentor_Mentee Day
선배님들 졸업식
준하,민희 실무자 1개월차
[Allern 문법 study]
[앱 만들어보기]


#####################################################################################2021.08.26
class TableViewBasicsViewController: UIViewController {
    
    let list = ["iPhone", "iPad", "Apple Watch", "iMac Pro", "iMac 5K", "Macbook Pro", "Apple TV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension TableViewBasicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("#1", #function)
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("#2", #function, indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = list[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        return cell
    }
    
    
}

#####################################################################################2021.08.24
Table View Basic
//Delegate Pattern을 활용해서 테이블 뷰를 구현하는 방법
class TableViewBasicsViewController: UIViewController {
    
    let list = ["iPhone", "iPad", "Apple Watch", "iMac Pro", "iMac 5K", "Macbook Pro", "Apple TV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
#####################################################################################2021.08.15_2
commit erreor 403??????????????
#Table View Basic = Delegate Pattern을 활용해서 테이블 뷰를 구현하는 방법
#Multi Section#1,#2 = 테이블 뷰에서 두 개 이상의 섹션을 표시하는 방법
#Separator = 셀을 구분하는 Separator
#Table View Cell = 테이블 뷰 셀 구조와 기본 스타일


#####################################################################################2021.08.15_1
#Table View Basic = Delegate Pattern을 활용해서 테이블 뷰를 구현하는 방법
#Multi Section#1,#2 = 테이블 뷰에서 두 개 이상의 섹션을 표시하는 방법
#Separator = 셀을 구분하는 Separator
#Table View Cell = 테이블 뷰 셀 구조와 기본 스타일



#####################################################################################2021.08.11
#Table View Over
#Table View Basic

#####################################################################################2021.08.10
#ISO8601DateFormatter
let str = "2017-09-02"

let formatter = ISO8601DateFormatter()
formatter.formatOptions = [.withYear, .withMonth, .withDay, .withDashSeparatorInDate] // =[withFullDate]

if let date = formatter.date(from: str) {
    formatter.formatOptions = [.withInternetDateTime]
    print(formatter.string(from: date))
    
} else {
    print("inavalid format")
}


#DateIntervalFormatter
let startDate = Date()
let endDate = startDate.addingTimeInterval(3600 * 24 * 3)

let formatter = DateFormatter()
formatter.locale = Locale(identifier: "ko_KR")
formatter.dateStyle = .long
formatter.timeStyle = .short

print("\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))")

let intervalFormatter = DateIntervalFormatter()
intervalFormatter.locale = Locale(identifier: "ko_KR")
//intervalFormatter.dateStyle = .long
//intervalFormatter.timeStyle = .short
intervalFormatter.dateTemplate = "yyyyMMMdE"



print(intervalFormatter.string(from: startDate, to: endDate))



#DateComponentsFormatter
let startDate = Date()
let endDate = startDate.addingTimeInterval(3600 * 24 * 30)

let formatter = DateComponentsFormatter()
formatter.unitsStyle = .full

if let result = formatter.string(from: startDate, to: endDate) {
    print(result)
}

var comps = DateComponents()
comps.day = 0
comps.hour = 1
comps.minute = 30
comps.minute = 0
comps.second = 7

formatter.unitsStyle = .positional //재생시간같이 표기 코드 ex)1:00:07
formatter.zeroFormattingBehavior = .pad  //4 weeks, 2 days 0d 01:00:07


//ex)90분으로 설정코드 = formatter.allowedUnits = [.minute]
//반올림 코드 = formatter.maximumUnitCount = 1
//remaining 남은시간 표시코드 = formatter.includesTimeRemainingPhrase = true
//remaining랑 같이 사용하는 코드 about = formatter.includesApproximationPhrase = true

if let result = formatter.string(from: comps) {
    print(result)
}


#####################################################################################2021.08.09
#ISO8601Date~
#Table View

#####################################################################################2021.08.08_5
#Date String Parsing
let str = "2017-09-02T09:30:00Z"
let formatter = DateFormatter()

formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

if let date = formatter.date(from: str) {
    formatter.dateStyle = .full
    formatter.timeStyle = .full
    
    print(formatter.string(from: date))
    
} else {
    print("invalid format")
    
}
#####################################################################################2021.08.08_4
#Symbols
#Symbols 
let now = Date()
let weekdaySymbols = ["☀️", "🌕", "🔥", "💧", "🌲", "🥇", "🌏"]
let am = "🌅"
let pm = "🌇"

let formatter = DateFormatter()
formatter.dateStyle = .full
formatter.timeStyle = .full

formatter.amSymbol = am
formatter.pmSymbol = pm

print(formatter.string(from: now))

formatter.weekdaySymbols = weekdaySymbols

print(formatter.string(from: now))




#####################################################################################2021.08.08_3
#Relative Date Formatting
let now = Date()
let yesterday = now.addingTimeInterval(3600 * -24)
let tomorrow = now.addingTimeInterval(3600 * 24)

let formatter = DateFormatter()
formatter.locale = Locale(identifier: "ko_KR")
formatter.dateStyle = .full
formatter.timeStyle = .none
formatter.doesRelativeDateFormatting = true


print(formatter.string(from: now))
print(formatter.string(from: yesterday))
print(formatter.string(from: tomorrow))
formatter.doesRelativeDateFormatting = true


#####################################################################################2021.08.08_2
#Custom Format
NSDateFormatter.com

let now = Date()
let formatter = DateFormatter()

formatter.locale = Locale(identifier: "en_US")
formatter.setLocalizedDateFormatFromTemplate("yyyyMMMMdE")
var result = formatter.string(from: now)
print(result, formatter.dateFormat)

formatter.locale = Locale(identifier: "ko_KR")
formatter.setLocalizedDateFormatFromTemplate("yyyyMMMMdE")
result = formatter.string(from: now)
print(result, formatter.dateFormat)

formatter.dateFormat = "yyyyMMMMdE"
result = formatter.string(from: now)
print(result)


#Relative Date Formatting
let now = Date()
let yesterday = now.addingTimeInterval(3600 * -24)
let tomorrow = now.addingTimeInterval(3600 * 24)

let formatter = DateFormatter()
formatter.locale = Locale(identifier: "ko_KR")
formatter.dateStyle = .full
formatter.timeStyle = .none
formatter.doesRelativeDateFormatting = true


print(formatter.string(from: now))
print(formatter.string(from: yesterday))
print(formatter.string(from: tomorrow))
formatter.doesRelativeDateFormatting = true


#####################################################################################2021.08.08
#DateFormatter
//문자를 날짜로 날짜를 문자로
let now = Date()
//print(now)

let formatter = DateFormatter()
formatter.dateStyle = .full
formatter.timeStyle = .medium
formatter.locale = Locale(identifier: "ko_kr")


var result = formatter.string(from: now)
print(result)

//formatter.string(for: <#T##Any?#>)

result = DateFormatter.localizedString(from: now, dateStyle: .long, timeStyle: .short)
print(result)



#####################################################################################2021.08.07_2
CountDown Timer
class CountDownTimerViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBAction func start(_ sender: Any) {
        timeLabel.text = "\(Int(picker.countDownDuration))"
    
            remainingSeconds = Int(picker.countDownDuration)
    
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.remainingSeconds -= 1
            self.timeLabel.text = "\(self.remainingSeconds)"
            
            if self.remainingSeconds == 0 {
                timer.invalidate()
                AudioServicesPlaySystemSound(1315)
            }
        }
    }
    
    var remainingSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.countDownDuration = 60//원하는 시간을 초 단위로
        
        
    }
}



#####################################################################################2021.08.07
Date Picker
class DatePickerModeViewController: UIViewController {
    
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        print(sender.date)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "ko_kr")
        
        picker.minuteInterval = 1
        
        picker.date = Date()
        picker.setDate(Date(), animated: true)
        
//        picker.minimumDate = Date()
//        picker.maximumDate = Date()
        
        picker.calendar = Calendar.current
        picker.timeZone = TimeZone.current
        
        
    }
}


#####################################################################################2021.08.06
Handling Date
#Date Picker

#####################################################################################2021.08.05_2
Calendar and Date Components
#Calendar
//국가별 달력이 다양하기 때문에 특정해서 사용해야 함.
Calendar.Identifier.gregorian//comm+cont+클릭(Identifier)

Calendar.current //아이폰설정상, 설정 바꿔도 최초달력 유지
Calendar.autoupdatingCurrent //아이폰설정상, 바꾼 달력으로 유지



#DateComponents
let now = Date()

let calendar = Calendar.current

let components = calendar.dateComponents([.year, .month, .day], from: now)
components.year
components.month
components.day
//여러가지를 볼 때

let year = calendar.component(.year, from: now)
//하나의 값만 볼 때

//새로운 날짜
var memorialDayComponents = DateComponents()
memorialDayComponents.year = 2014
memorialDayComponents.month = 4
memorialDayComponents.day = 16

let memorialDay = calendar.date(from: memorialDayComponents)


#Date Calculation
extension Date {
    init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0, calendar: Calendar = .current) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.day = day
        
        guard let date = calendar.date(from: components) else {
            return nil
        }
        
        self = date
    }
}

let calendar = Calendar.current
let worldCup2002 = Date(year: 2002, month: 5, day: 31)!

//100일 뒤 날짜 설정
let now = Date()
let today = calendar.startOfDay(for: now) //기준날짜 설정 00:00분

var comps = DateComponents()
comps.day = 100 //100일 전 날짜를 하고 싶으면 -100
comps.hour = 12 // 시간부분을 생각해서 계산해야 된다.  하루 차이가 날 수 있음

calendar.date(byAdding: comps, to: now)
calendar.date(byAdding: comps, to: today) //시간 뺀 날짜만

comps = calendar.dateComponents([.day], from: worldCup2002, to: today)
comps.day


#TimeZone
//한국 Korean Standard Time(KST)
let calendar = Calendar.current
var components = DateComponents()
components.year = 2014
components.month = 4
components.day = 16
//서울/아시아로 타임존 설정
components.timeZone = TimeZone(identifier: "Asia/Seoul")
calendar.date(from: components)

components.timeZone = TimeZone(identifier: "America/Los_Angels")
calendar.date(from: components)



for name in TimeZone.knownTimeZoneIdentifiers {
    print(name)
}//Asia/Seoul




#####################################################################################2021.08.05
Date
#Date Type and Reference Date
Reference date: 2001-01-01 00:00:00 / UTC

let now = Date()
print(now)

var dt = Date(timeIntervalSinceReferenceDate: 60 * 60)
print(dt)

dt = Date(timeIntervalSinceReferenceDate: -60 * 60)
print(dt)


#TimeInterval
let oneSec = TimeInterval(1)

let oneMillisecond = TimeInterval(0.001)

let oneMin = TimeInterval(60)
let oneHour = TimeInterval(oneMin * 60) //= (60 * 60)
let oneDay = TimeInterval(oneHour * 24)

Date(timeIntervalSinceNow: oneDay)





#####################################################################################2021.08.04_3
Input View& Input Accessory View
class InputViewViewController: UIViewController {
    
    
    @IBOutlet var accessoryBar: UIToolbar!
    
    
    @IBOutlet var pickerContainerView: UIView!
    
    
    @IBOutlet var buttonContainerView: UIView!
    
    
    @IBAction func selectGender(_ sender: UIButton) {
        
        genderField.text = sender.tag == 0 ? "M" : "F"
        
        UIDevice.current.playInputClick()
    }
    
    @IBAction func movePrevious(_ sender: Any) {
        if genderField.isFirstResponder {
            ageField.becomeFirstResponder()
        } else if ageField.isFirstResponder {
            nameField.becomeFirstResponder()
        }
    }
    
    @IBAction func moveNext(_ sender: Any) {
        if nameField.isFirstResponder {
            ageField.becomeFirstResponder()
        } else if ageField.isFirstResponder {
            genderField.becomeFirstResponder()
        }
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageField.inputView = pickerContainerView
        genderField.inputView = buttonContainerView
        
        
        nameField.inputAccessoryView = accessoryBar
        ageField.inputAccessoryView = accessoryBar
        genderField.inputAccessoryView = accessoryBar
    }
}


class GenderInputView: UIView, UIInputViewAudioFeedback {
    var enableInputClicksWhenVisible: Bool {
        return true
    }
}





extension InputViewViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
}

extension InputViewViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ageField.text = "\(row + 1)"
    }
}


#####################################################################################2021.08.04
Text Delegates #1~#3
//Name,Age,Gender,Email

class TextDelegateViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    lazy var charSet = CharacterSet(charactersIn: "0123456789").inverted
    lazy var invalidGenderCharSet = CharacterSet(charactersIn: "MF").inverted
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.becomeFirstResponder()
    }
}

extension TextDelegateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameField:
            ageField.becomeFirstResponder()
        case ageField:
            genderField.becomeFirstResponder()
        case genderField:
            emailField.becomeFirstResponder()
        case emailField:
            emailField.resignFirstResponder()
        default:
            break
    }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("current: \(textField.text ?? "")")
        print("string: \(string)")
        
        let currentText = NSString(string: textField.text ?? "")
        let finalText = currentText.replacingCharacters(in: range, with: string)
        
        switch textField {
        case nameField:
            if finalText.count > 10 {
                return false
            }
        case ageField:

            if let _ = string.rangeOfCharacter(from: charSet) {
                return false
            }
                    if let age = Int(finalText), !(1...100).contains(age) {
                        return false
                    }
        case genderField:
            if let _ = string.rangeOfCharacter(from: invalidGenderCharSet) {
                return false
            }
            
            if finalText.count > 1 {
                return false
            }
            
        default:
            break
        }
        
        
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            guard let email = textField.text, let _ = email.range(of: regex, options: .regularExpression) else {
                alert(message: "invalid email")
                return false
            }
            }
        
        
        return true
    }

    }

extension TextDelegateViewController {
    func alert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}

#####################################################################################2021.08.04
Software Keyboard #3
//Notification 이름을 주석으로 추가해둠
// UIResponder.keyboardDidHideNotification
// UIResponder.keyboardDidShowNotification
// UIResponder.keyboardWillHideNotification
// UIResponder.keyboardWillShowNotification
// UIResponder.keyboardWillChangeFrameNotification
// UIResponder.keyboardDidChangeFrameNotification


class KeyboardNotificationViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
            
            guard let userInfo = noti.userInfo else { return }
            
            guard let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?
                    CGRect else { return }
            
            var inset = self.textView.contentInset
            inset.bottom = frame.height
            self.textView.contentInset = inset
            
            self.textView.scrollIndicatorInsets = inset
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
            
            var inset = self.textView.contentInset
            inset.bottom = 8
            self.textView.contentInset = inset
            
            self.textView.scrollIndicatorInsets = inset
        }
        
    }
}



#####################################################################################2021.08.03
Software Keyboard #2
class ReturnKeyViewController: UIViewController {
    
    @IBOutlet weak var firstInputField: UITextField!
    
    @IBOutlet weak var secondInputField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //리턴키 코드
        secondInputField.enablesReturnKeyAutomatically = true
        
    }
}

extension ReturnKeyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstInputField:
            secondInputField.becomeFirstResponder()
        case secondInputField:
            guard let keyword = secondInputField.text, keyword.count > 0 else {
                return true
            }
            let encodeKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyword
            let urlStr = "http://www.google.com/m/search?q=\(encodeKeyword)"
            guard let url = URL(string: urlStr) else {
                return true
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        default:
            break
        }
        return true
        //델리게이트에서 구현하면 리턴키를 탭할때마다 반복적으로 호출한다
    }
}



#####################################################################################2021.08.02
Software Keyboard #1
_FirstResponderViewController
class FirstResponderViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    
    @IBAction func startEditing(_ sender: Any) {
        inputField.becomeFirstResponder()
    }
    
    @IBAction func endEditing(_ sender: Any) {
        if inputField.isFirstResponder {
            inputField.resignFirstResponder()
        }
    }
    //will로 열었으면, dis로 닫아준다 짝을 맞추듯
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        if inputField.isFirstResponder {
//            inputField.resignFirstResponder()
//        }
        view.endEditing(true) //위 주석이랑 같은 효과
    }
}

_KeyboardTypesViewController.swift
class KeyboardTypesViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func changeKeyboardType(_ sender: Any) {
        inputField.resignFirstResponder()
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let types: [UIKeyboardType] = [.default, .asciiCapable, .numbersAndPunctuation, .URL, .numberPad, .phonePad, .namePhonePad, .emailAddress, .decimalPad, .twitter, .webSearch, .asciiCapableNumberPad]
        let typeNames = ["Default", "ASCII Capable", "Numbers And Punctuation", "URL", "Number Pad", "Phone Pad", "Name Phone Pad", "E-mail Address", "Decimal Pad", "Twitter", "Web Search", "ASCII Capable Number Pad"]
        
        (0..<types.count).forEach {
            let type = types[$0]
            let name = typeNames[$0]
            
            let action = UIAlertAction(title: name, style: .default, handler: { (action) in
                self.inputField.keyboardType = type
                self.inputField.becomeFirstResponder()
            })
            sheet.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        sheet.addAction(cancel)
        
        if let pc = sheet.popoverPresentationController {
            pc.sourceView = btn
        }
        
        present(sheet, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
}

_KeyboardAppearanceViewController
class KeyboardAppearanceViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func appearanceChanged(_ sender: UISegmentedControl) {
        let appearance = UIKeyboardAppearance(rawValue: sender.selectedSegmentIndex) ?? .default
        inputField.keyboardAppearance = appearance
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
}



#####################################################################################2021.08.01_2
#😎Text Input Traits #1~#2
#1
텍스트 입력
class CapitalizationViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func capitalizationChanged(_ sender: UISegmentedControl) {
        
        inputField.resignFirstResponder()
        
        let type = UITextAutocapitalizationType(rawValue: sender.selectedSegmentIndex) ?? .none
        inputField.autocapitalizationType = type
        
        inputField.becomeFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
    }
}

class CorrectionViewController: UIViewController {
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func correctionChanged(_ sender: UISegmentedControl) {
        //편집종료
        inputField.resignFirstResponder()
        
        let type = UITextAutocorrectionType(rawValue: sender.selectedSegmentIndex) ?? .default
        inputField.autocorrectionType = type
        //편집다시시작
        inputField.becomeFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

#2
#SpellChecking
//오타 밑줄 빨간색
class SpellCheckingViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func spellCheckingChanged(_ sender: UISegmentedControl) {
    
        let type = UITextSpellCheckingType(rawValue: sender.selectedSegmentIndex) ?? .default
        textView.spellCheckingType = type
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


#SecureTextEntry
class SecureTextEntryViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.isSecureTextEntry = true
        
    }
}

#https://ko.wikipedia.org/wiki/줄표#엠_대시(em_dash,_—)
엠대시, 엔대시



#####################################################################################2021.08.01_1

#3😎 Text View #3 Data Detections
class DataDetectionViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.dataDetectorTypes = [.link, .address, .phoneNumber]
        
    }
}


#####################################################################################2021.07.31_3
Text Field#1~#2
#1😎 Basic
class TextFieldViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var valueLabel: UILabel!
   
    @IBAction func report(_ sender: Any) {
        
        guard let text = inputField.text, text.count > 0 else {
            return
        }
        valueLabel.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputField.placeholder = "Input Value"
    }
}


#2😎
Border Style
class TextFieldBorderStyleViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var borderStyleControl: UISegmentedControl!
    
    @IBAction func borderStyleChanged(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        let style = UITextField.BorderStyle(rawValue: index) ?? .roundedRect
        inputField.borderStyle = style
    }
    
    
    @IBOutlet weak var enabledSwitch: UISwitch!
    
    @IBAction func toggleEnabled(_ sender: UISwitch) {
        inputField.isEnabled = sender.isOn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

#####################################################################################2021.07.31_2
Color#1,#2
_Color#1 Color Basic
class CGColorCIColorViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueView.layer.borderWidth = 10
        blueView.layer.borderColor = UIColor.systemYellow.cgColor
        
    }
}


_Color#2 Pattern
#1😎 UIColor
class UIColorViewController: UIViewController {
    
    @IBOutlet weak var targetView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let r = CGFloat(redSlider.value)
        let g = CGFloat(redSlider.value)
        let b = CGFloat(redSlider.value)
        
        targetView.backgroundColor = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        
        targetView.backgroundColor?.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        redSlider.value = Float(r)
        greenSlider.value = Float(g)
        blueSlider.value = Float(b)
        
        
//        targetView.backgroundColor = UIColor.systemBlue
//
//        let color = UIColor(red: 29.0 / 255.0, green: 161.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
//
//        UIColor(displayP3Red: 29.0 / 255.0, green: 161.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
//
//        UIColor.systemRed.withAlphaComponent(0.5)
//
//        UIColor.clear
        
    }
}


#2😎 CGColor
class CGColorCIColorViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueView.layer.borderWidth = 10
        blueView.layer.borderColor = UIColor.systemYellow.cgColor
        
    }
}

#3😎 Pattern
class PatternImageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = UIImage(named: "pattern") {
            let patternColor = UIColor(patternImage: img)
            view.backgroundColor = patternColor
        }
    }
}


#4😎 Color Literal
class ColorSetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let c = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        view.backgroundColor = UIColor(named: "PrimaryColor") ?? UIColor.white
        
    }
}

#5😎
Custom Drawing
class ColorSetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let c = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        view.backgroundColor = UIColor(named: "PrimaryColor") ?? UIColor.white
        
    }
}



#####################################################################################2021.07.31
Image#3~#4
#3_Image#3 Template Images
class RenderingModeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = UIImage(named: "clover")?.withRenderingMode(.alwaysTemplate) {
            imageView.image = img
        }
    }

#4_Image#4 Custom Drawing and Resizing
import UIKit
import CoreGraphics

class ImageResizingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let targetImage = UIImage(named: "photo") {
            let size = CGSize(width: targetImage.size.width / 5, height: targetImage.size.height / 5)
            
            imageView.image = resizingWithImageContext(image: targetImage, to: size)
        }
    }
}




extension ImageResizingViewController {
    func resizingWithImageContext(image: UIImage, to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        let frame = CGRect(origin: CGPoint.zero, size: size)
        image.draw(in: frame)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndPDFContext()
        
        return resultImage
        
    }
}



extension ImageResizingViewController {
    func resizingWithBitmapContext(image: UIImage, to size: CGSize) -> UIImage? {
        return nil
    }
}






#####################################################################################2021.07.30
Image#1~#2
_#1 Image Basic
class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img1 = UIImage(named: "moongchi")
        let img2 = #imageLiteral(resourceName: "photo") //Image Litera
        
        imageView.image = img1   //nil
        
        if let ptSize = img1?.size {
            print("Image Size: \(ptSize)")
        }
        
        if let ptSize = img1?.size, let scale = img1?.scale {
            let px = CGSize(width: ptSize.width * scale, height: ptSize.height * scale)
            print("Image Size(px): \(px)")
        }
        //유형
        img1?.cgImage
        img1?.ciImage
        
        //다른곳으로 전송 및 파일저장
        let pngData = img1?.pngData()
        let jpgData = img1?.jpegData(compressionQuality: 1.0)//1.0이 가장 높은품질
        
    }
}

_#2 Image #2 Resizable Image&Vector Image
class ResizableImageViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    let btnImage = UIImage(named: "btn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = btnImage {
            let capInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
            
            let bkgImage = img.resizableImage(withCapInsets: capInset, resizingMode:  .stretch)
            btn.setBackgroundImage(bkgImage, for: .normal)
        }
        
    }


#####################################################################################2021.07.29_2
Handling Image and Color
_Image View
class ImageAnimationViewController: UIViewController {
    
    let images = [
        UIImage(systemName: "speaker")!,
        UIImage(systemName: "speaker.1")!,
        UIImage(systemName: "speaker.2")!,
        UIImage(systemName: "speaker.3")!
    ]
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func startAnimation(_ sender: Any) {
        imageView.startAnimating()
    }
    
    @IBAction func stopAnimation(_ sender: Any) {
        if imageView.isAnimating {
            imageView.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.animationImages = images
        
        imageView.animationDuration = 1.0
        imageView.animationRepeatCount = 3
    }
}

#####################################################################################2021.07.29
Alert#3😎
#3😎
class ActionSheetViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func show(_ sender: UIButton) {
        let controller = UIAlertController(title: "Languages", message: "Choose one", preferredStyle: .actionSheet)
        
        let swiftAction = UIAlertAction(title: "Swift", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(swiftAction)
        
        let javaAction = UIAlertAction(title: "Java", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(javaAction)
        
        let pythonAction = UIAlertAction(title: "Python", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(pythonAction)
        
        let cSharpAction = UIAlertAction(title: "C#", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(cSharpAction)
        
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { [weak self] (action) in
            self?.resultLabel.text = nil
        }
        controller.addAction(clearAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
   
        
        if let pc = controller.popoverPresentationController {
            //pc.barButtonItem
            pc.sourceView = view
            pc.sourceRect = sender.frame
        }
        
        for action in controller.actions {
            if action.title == resultLabel.text {
                action.isEnabled = false
            }
        }
        
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

#####################################################################################2021.07.28
_Alert Controller#1~#2
#1😎
class AlertViewController: UIViewController {
    
    @IBAction func show(_ sender: Any) {
        let controller = UIAlertController(title: "Hello", message: "Have a nice day", preferredStyle: .alert)
     //얼러트에는 반드시 액션이 들어가야 함
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print(action.title)                 //style메세지에는 .누르면 확인가능 3개(cancel:닫기, destructive:빨간색(주의), default: 기본)
        }
        controller.addAction(okAction)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print(action.title)
        }
        controller.addAction(cancelAction)
        
        let destructiveAction = UIAlertAction(title: "Destructive", style: .destructive) { (action) in
            print(action.title)
        }
        controller.addAction(destructiveAction)
        
        controller.preferredAction = okAction
        //prefeerd는 present 전에 지정해줘야 한다, alert에서만 사용.
            present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

#2😎
//[경고창에 텍스트 필드 추가]
class AddTextFieldViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func show(_ sender: Any) {
        let controller = UIAlertController(title: "Sign Un to iTunes Store", message: nil, preferredStyle: .alert)
        
        controller.addTextField { (idField) in
            idField.placeholder = "Apple ID"
        }
        

        controller.addTextField { (passwordField) in
            passwordField.placeholder = "Input Password"
            passwordField.isSecureTextEntry = true   //password는 마스킹
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] (action) in
            if let fieldList = controller.textFields {
                if let idField = fieldList.first {
                    self?.idLabel.text = idField.text
                }
                
                if let passwordField = fieldList.last {
                    self?.passwordLabel.text = passwordField.text
                }
            }
        }
        controller.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




#####################################################################################2021.07.26
_Progress View
class ProgressViewViewController: UIViewController {
  
    @IBOutlet weak var progress: UIProgressView!
    
    
    
    @IBAction func update(_ sender: Any) {
        //progress.progress = 0.8 애니메이션 없이 바로 로드됨
        progress.setProgress(0.8, animated: true) // 애니메이션 효과
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.progress = 0.0
        progress.trackTintColor = UIColor.systemGray
        progress.progressTintColor = .systemRed
        
    }
}



#####################################################################################2021.07.25_3
_Switch
class SwitchViewController: UIViewController {
    
    @IBOutlet weak var bulbImageView: UIImageView!
    
    @IBOutlet weak var testSwitch: UISwitch!
    
    
    @IBAction func stateChanged(_ sender: UISwitch) {
        bulbImageView.isHighlighted = sender.isOn
        
    }
    
    
    
    
    @IBAction func toggle(_ sender: Any) {
        //testSwitch.isOn.toggle()
        
        testSwitch.setOn(!testSwitch.isOn, animated: true)
        stateChanged(testSwitch)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        testSwitch.isOn = bulbImageView.isHighlighted
    }
}

_Stepper
class StepperViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueStepper: UIStepper!
    @IBOutlet weak var autorepeatSwitch: UISwitch!
    @IBOutlet weak var continuousSwitch: UISwitch!
    @IBOutlet weak var wrapSwitch: UISwitch!
    
    @IBAction func valueChanged(_ sender: UIStepper) {
        valueLabel.text = "\(sender.value)"
    }
    
    
    
    @IBAction func toggleAutorepeat(_ sender: UISwitch) {
        valueStepper.autorepeat = sender.isOn
        
    }
    
    @IBAction func toggleContinuous(_ sender: UISwitch) {
        valueStepper.isContinuous = sender.isOn
        
    }
    
    @IBAction func toggleWrap(_ sender: UISwitch) {
        valueStepper.wraps = sender.isOn
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autorepeatSwitch.isOn = valueStepper.autorepeat
        continuousSwitch.isOn = valueStepper.isContinuous
        wrapSwitch.isOn = valueStepper.wraps
        
    }
}

_Activity Indicator View
class ActivityIndicatorViewViewController: UIViewController {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var hiddenSwitch: UISwitch!
    
    @IBAction func toggleHidden(_ sender: UISwitch) {
        loader.hidesWhenStopped = sender.isOn
    }
    
    @IBAction func start(_ sender: Any) {
        if !loader.isAnimating {
        loader.startAnimating()
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if loader.isAnimating {
            loader.stopAnimating()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiddenSwitch.isOn = loader.hidesWhenStopped
        loader.startAnimating()
        
    }
}

#####################################################################################2021.07.25_2
_Slider#1
class SimpleSliderViewController: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var blueSlider: UISlider!
    
    
    @IBAction func sliderChanged(_ sender: Any) {
        
        let r = CGFloat(redSlider.value)
        let g = CGFloat(greenSlider.value)
        let b = CGFloat(blueSlider.value)
        
        let color = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        view.backgroundColor = color
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.value = 1.0
        greenSlider.value = 1.0
        blueSlider.value = 1.0
        
        //애니메이션 효과 넣기
        //redSlider.setValue(, animated: <#T##Bool#>)
        
        redSlider.minimumValue = 0.0
        redSlider.maximumValue = 1.0
    }
}

_Slider#2
Custom Slider
class CustomSliderViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(systemName: "Lightbuld")
        
        slider.setThumbImage(img, for: .normal)
        
        slider.minimumTrackTintColor = UIColor.systemRed
        slider.maximumTrackTintColor = UIColor.black
        
        //틴트컬러 이미지
        //slider.thumbTintColor
        
//        slider.setMinimumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//        slider.setMaximumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//
        
    }
}


non-continuous Slider
class CustomSliderViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(systemName: "Lightbuld")
        
        slider.setThumbImage(img, for: .normal)
        
        slider.minimumTrackTintColor = UIColor.systemRed
        slider.maximumTrackTintColor = UIColor.black
        
        //틴트컬러 이미지
        //slider.thumbTintColor
        
//        slider.setMinimumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//        slider.setMaximumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//
        
    }
}




#####################################################################################2021.07.25
_Page Control#1
class PageControlViewController: UIViewController {
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    
    @IBOutlet weak var pager: UIPageControl!
    
    
    let list = [UIColor.red, UIColor.green, UIColor.blue, UIColor.gray, UIColor.black]
    
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        listCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pager.numberOfPages = list.count
        pager.currentPage = 0
        
        pager.pageIndicatorTintColor = UIColor.systemGray3
        pager.currentPageIndicatorTintColor = UIColor.systemRed
        
    }
}


extension PageControlViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width / 2.0)
        
        let newPage = Int(x / width)
        if pager.currentPage != newPage {
            pager.currentPage = newPage
        }
    }
}





extension PageControlViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = list[indexPath.item]
        return cell
    }
}


extension PageControlViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

#####################################################################################2021.07.24_3
_Picker View#1. Text Picker
//Picker View = 슬롯머신형태
1. Date Picker(날짜 등)
2. Picker View(범용적)

class TextPickerViewController: UIViewController {
    let devTools = ["Xcode", "Postman", "SourceTree", "Zeplin", "Android Studio", "SublimeText"]
    let fruits = ["Apple", "Orange", "Banana", "Kiwi", "Watermelon", "Peach", "Strawberry"]
    
    
    @IBOutlet weak var picker: UIPickerView!
    

    @IBAction func report(_ sender: Any) {
        
        let firstSelectedRow = picker.selectedRow(inComponent: 0)
        let secondSelectedRow = picker.selectedRow(inComponent: 1)
        
        if firstSelectedRow >= 0 {
           print(devTools[firstSelectedRow])
        }
        
        if secondSelectedRow >= 0 {
            print(fruits[secondSelectedRow])
        }
        
        
        
//       let row = picker.selectedRow(inComponent: 0)
//
//        guard row >= 0 else {
//            print("not found")
//            return
//        }
//        print(devTools[row])
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



extension TextPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return devTools.count
        case 1:
            return fruits.count
        default:
            return 0
        }
    }
}

extension TextPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        switch component {
        case 0:
            return devTools[row]
        case 1:
            return fruits[row]
        default:
            return nil
        }
    }
    
    
    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            print(devTools[row])
        case 1:
            return(fruits[row])
        default:
            break
            
        
    }
}



#####################################################################################2021.07.24_2
_Button #2. Text Button
class ImageButtonViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    d
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let normalImage = UIImage(named: "plus-normal")
        let highlightedImage = UIImage(named: "plus-highlighted")
        
        btn.setImage(normalImage, for: .normal)
        btn.setImage(highlightedImage, for: .highlighted)
        
        btn.setBackgroundImage
//이미지?,,,,상태,,,???
    }
}

#####################################################################################2021.07.24_1
_Button #1. Text Button
class TextButtonViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //버튼을 타이틀레이블에 직접 접근해서 바꾸는것을 허용x
        //UI버튼이 제공하는 메소드를 사용해야 한다.
//        btn.titleLabel?.text = "Hello"
//        btn.titleLabel?.textColor = .systemRed
        
       //-->>> 
        btn.setTitle("Hello", for: .normal)
        btn.setTitle("Haha", for: .highlighted)
        
        btn.setTitleColor(.systemRed, for: .normal)
        btn.setTitleColor(.systemPurple, for: .highlighted)
        
        btn.titleLabel?.backgroundColor = .systemYellow
    }
}



#####################################################################################2021.07.24
System View & Control
_UIControl & Target-Action
_Button#1 Text Button
_Button#2 Image Button



#####################################################################################2021.07.22_2
View & Window
_UIView#3
class InteractionViewController: UIViewController {
    
    @IBOutlet weak var interactionSwitch: UISwitch!
    
    @IBOutlet weak var multiTouchSwitch: UISwitch!
    
    @IBOutlet weak var touchView: TouchView!
    
    
    @IBAction func switchInteractionEnabled(_ sender: UISwitch) {
        touchView.isUserInteractionEnabled = sender.isOn
    }
    
    
    @IBAction func switchMultiTouch(_ sender: UISwitch) {
        touchView.isMultipleTouchEnabled = sender.isOn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactionSwitch.isOn = touchView.isUserInteractionEnabled
        multiTouchSwitch.isOn = touchView.isMultipleTouchEnabled
    }   
}

#####################################################################################2021.07.22
View & Window
_UIView#2
//option + 클릭
class ContentModeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var modeLabel: UILabel!
    
    @IBAction func switchMode(_ sender: Any) {
        let currentMode = imageView.contentMode.rawValue
        
        let newMode =  UIView.ContentMode(rawValue: currentMode + 1) ?? . scaleAspectFill
        imageView.contentMode = newMode
        
        updateModeLabel()
        
    }
    
    func updateModeLabel() {
        switch imageView.contentMode {
        case .scaleToFill:
            modeLabel.text = "Scale to fill"
        case .scaleAspectFit:
            modeLabel.text = "Aspect fit"
        case .scaleAspectFill:
            modeLabel.text = "Aspect fill"
        case .redraw:
            modeLabel.text = "Redraw"
        case .center:
            modeLabel.text = "Center"
        case .top:
            modeLabel.text = "Top"
        case .bottom:
            modeLabel.text = "Bottom"
        case .left:
            modeLabel.text = "Left"
        case .right:
            modeLabel.text = "Right"
        case .topLeft:
            modeLabel.text = "Top left"
        case .topRight:
            modeLabel.text = "Top right"
        case .bottomLeft:
            modeLabel.text = "Bottom left"
        case .bottomRight:
            modeLabel.text = "Bottom right"
        @unknown default:
            fatalError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.layer.borderWidth = 2
        
        updateModeLabel()
    }
}

#####################################################################################2021.07.21
2021.07.21
단축키
option + del : 단어지우기
comm + del : 문단지우기
contr + del : 대소문자 지우기 
comm + option + [] : 줄내리기 올리기
com + 0, com+option + 0 : 좌우 닫기열기

현재창 빼고 닫기 : comm+option+w
현재창 닫기 : comm+w
*코드자동정렬 : contr+I
*comm+, : 설정
줄지우기 설정하기" : comm+option+del
같은단어 수정 : comm+클릭 리네임
같은 글쓰기 : comm+Shift
단어 첫줄끝줄 : option+방향키
문단 첫줄끝줄 : comm+방향키 

단어블록 : option+shift 방향키
문단블록 : comm+shift 방향키

인터넷
-comm+space bar 검색
-comm+L 주소창검색

파일
space bar "미리보기"

응용프로그램종료(작업관리자) : option+comm+esc

커맨트 엘 숫자 : 코드숫자 바로가기
커맨드 시프트 4 : 캡쳐
커맨드 시프트 5 : 녹화


다운로드 원할 때, 드래그 해서 독에 있는 다운로드로 



#####################################################################################2021.07.20
System View & control


#####################################################################################2021.07.19
View & Window
_UIView

System View & Control



#####################################################################################2021.07.18
View & Window
_Overview
Text Views - Label, Text Field, Text View

Controls - Button, Switch, Slider, Page Control, Date Picker, Segmented Control, Steeper

Content Views - Image View, Picker View, Progress View,

                             Activity Indicator View, Web View, Map View

Container Views - Scroll View, Table View, Collection View

Bars - Navigation Bar, Tab Bar, Tool Bar, Search Bar



#####################################################################################2021.07.17
_Outlet and Action
_Delegate Pattern

#####################################################################################2021.07.16
_Mastering iOS
_Interface Builder

#####################################################################################2021.07.15
Mastering iOS
_Hello, Interface Builder
_Outlet and Action

#####################################################################################2021.07.13
Mastering iOS
_Hello, iOS Project
_Hello, Xcode


#####################################################################################2021.07.13
NEXT_iOS!

Inheritance and Polymorphism
_Inheritance
//상속
class Figure {
    var name = "Unknow"
    
    init(name: String){
        self.name = name
    }
    
    func draw() {
        print("draw \(name)")
    }
}

class Circle: Figure {
    var radius = 0.0
}

let c = Circle(name: "Circle")
c.radius
c.name
c.draw()
//서브클래스는 슈퍼클래스로부터 상속

final class
//파이널클래스는 상속이 금지
final Rectangle: Figure {
    var width = 0.0
    var height = 0.0
}

class Square: Rectangle {
    
}

#####################################################################################2021.07.11_3
Method and Subscrip
_
class Sample {
var data = 0
static var sharedDate = 123

func doSomething() {
    print(data)
    Sample.sharedDate
}

func call() {
    doSomething()
}
}

let a = Sample()
a.data
a.doSomething()
a.call()

struct Size {
var width = 0.0
var height = 0.0
//가평식에서 속성을 바꾸는 메소드를 구현할 때 , 반드시 뮤테이팅으로 선언해야한다.
mutating func enlarge() {
    width += 1.0
    height += 1.0
}
}

var s = Size()
s.enlarge()

_Type Method
Type Methods
class Circle {
    static let pi = 3.14
    var radius = 0.0
    
    func getArea() -> Double {
        return radius * radius * Circle.pi
    }
    class func printPi() {
        print(pi)
    }
}

Circle.printPi()

class StrokeCircle: Circle {
    override static func printPi() {
        print(pi)
    }
}

_Subscripts
let list = ["A", "B", "C"]
list[0]

class List {
var data = [1, 2, 3]
    subscript(i index: Int) -> Int {
        get {
            return data[index]
        }
        
        set {
            data[index] = newValue
        }
    }
}


var l = List()
l[i: 0]

l[i: 1] = 123

struct Matrix {
    var data = [[1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]]
    
    subscript(row: Int, col: Int) -> Int {
        return data[row][col]
    }
}

let m = Matrix()
m[0, 0]

#####################################################################################2021.07.11_3
Property
_Stored Properties
struct Person {
    let name: String = "John Doe"
    var age: Int = 33


Explicit Member Expression
var p = Person()
p.name
p.age

p.age = 30

Lazy Stored Properties
struct Image {
    init() {
        print("new image")
    }
}

struct BlogPost {
    let title: String = "Title"
    let content: String = "Content"
    lazy var attachment: Image = Image()
    
    let date: Date = Date()
    
    lazy var formattedDate: String = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .medium
        return f.string(from: date)
    }
}

var post = BlogPost()
post.attachment


_Computed Properties
class Person {
   var name: String
   var yearOfBirth: Int

   init(name: String, year: Int) {
      self.name = name
      self.yearOfBirth = year
   }
    
    var age: Int {
            let calendar = Calendar.current
            let now = Date()
            let year = calendar.component(.year, from: now)
            return year - yearOfBirth
    
    }
}

let p = Person(name: "Jogn", year: 2002)
p.age

p.yearOfBirth


_Property Observer
class Size {
    var width = 0.0 {
        willSet {
            print(width, "=>", newValue)
        }
        didSet {
        print(oldValue, "=>", width)
        }
    }
}

let s = Size()
s.width = 123


_Type Properties
Stored Type Properties

class Math {
    static let pi = 3.14
}

let m = Math()
//m.pi
Math.pi


Computed Type Properties

enum Weekday: Int {
    case sunday = 1, monday, tuesday, wednesday,
         thursday, friday, saturday
    
    static var today: Weekday {
        let cal = Calendar.current
        let today = Date()
        let weekday = cal.component(.weekday, from: today)
        return Weekday(rawValue: weekday)!
        
    }
}

Weekday.today


_self
struct Size {
   var width = 0.0
   var height = 0.0
    
    mutating func reset(value: Double) {
//        width = value
//        height = value
        self = Size(width: value, height: value)
    }
}



//    func calcArea() -> Double {
//        return width * height
//    }
//
//    var area: Double {
//        return calcArea()
//    }
//
//    func update(width: Double, height: Double) {
//        self.width = width
//        self.height = height
//    }
//
//    func doSomething() {
//        let c = { self.width * self.height}
//    }
//
//    static let unit = ""
//
//    static func doSomething() {
//        //self.width
//        self.unit
//
//    }
//}
//셀프는 현재의 인스턴스에 접근하기 위해 사용하는 특별한 속성이다
//셀프를 타입멤버에서 사용하면 인스턴스가 아닌 형식 자체를 나타낸다

#####################################################################################2021.07.11_2
Structure and Class
_Structure
struct Person {
    var name: String
    var age: Int
    
    func speak() {
        print("Hello")
    }
}


let p = Person(name: "Steve", age: 50)

let name = "Paul"
name

p.name
p.age

p.speak()


Class
class Person {
    var name = "John Doe"
    var age = 0
    
    func speak() {
        print("Hello")
    }
}

let p = Person()

_Initializer Syntax
let str = "123"
let num = Int(str)

class Position {
    var x: Double
    var y: Double
    
    init() {
        x = 0.0
        y = 0.0
    }

//생성자는 속성 초기화가 제일 중요하고 유일한 목적, 생성자 실행이 종료되는 시점에는 모든 속성의 초기값이 저장되어 있어야 한다.

init(value: Double) {
    x = value
    y = value
  }
}

let a = Position()
a.x
a.y

let b = Position(value: 100)
b.x
b.y
//열거형,구조체,클래스는 모두 설계도이다
//설계도에 따라서 인스턴스를 만들기 위해서는 초기화 과정이 반드시 필요
//생성자를 호출하면 초기화가 시작되고 생성자 실행이 완료되면 모든 속성이 초기화된다
//에러 없이 초기화가 되면 인스턴스 생성

_Value Types and Reference Types
//가평식과 참조형식의 차이점
//분류방법
//스위프트에서 가평식은(구조체,열거형,튜플)  참조형식(클래스,클로져)

struct PositionValue {
    var x = 0.0
    var y = 0.0
}

var v = PositionValue()
var o = PositionValue()


var v2 = v
var o2 = o

v2.x = 12
v2.y = 34

v
v2


o2.x = 12
o2.y = 34

o
o2

_Nested Types
//형식 내부의 선언된 형식

class One {
    struct Two {
        enum Three {
            case a
            
            class Four {
                
            }
        }
    }
    
    var a = Two()
}

let two: One.Two = One.Two()



#####################################################################################2021.07.11
Enumeration
_Enumeration Types
let left = "left"
let center = "center"
let right = "right"

var alignment = center

if alignment == "Center" {
    
}

_Syntax
enum Alignment {
    case left
    case right
    case center
}

Alignment.center

var textAlignment = Alignment.center

textAlignment = .left

if textAlignment == .center {
    
}

switch textAlignment {
case .left:
    print("left")
case .right:
    print("right")
case .center:
    print("center")
}

###################2021.07.10_2
Set#1
Set

Set Type
//중복된 요소는 무시한다
let set: Set<Int> = [1, 2, 2, 3, 3, 3]
set.count


Inspecting a Set
set.count
//비어있는지 확인
set.isEmpty

Testing for Membership
//요소가 포함되어 있는지 확인
set.contains(1)

Adding and Removing Elements
var words = Set<String>()

var insertResult = words.insert("Swift")
insertResult.inserted
insertResult.memberAfterInsert

insertResult = words.insert("Swift")
insertResult.inserted
insertResult.memberAfterInsert

var updateResult = words.update(with: "Swift")
updateResult

updateResult = words.update(with: "Apple")
updateResult

var value = "Swift"
value.hashValue

updateResult = words.update(with: "value")
updateResult

value = "Hello"
value.hashValue

updateResult = words.update(with: "value")
updateResult

struct SampleData: Hashable {
    var hashValue: Int = 123
    var data: String
    
    init(  data: String) {
        self.data = data
    }
    static func ==(lhs: SampleData, rhs: SampleData)
    -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}


var sampleSet = Set<SampleData>()

var data = SampleData("Swift")
data.hashValue

var r = sampleSet.insert(data)
r.inserted
r.memberAfterInsert
sampleSet

data.data = insertResult(data)
r.inserted
r.memberAfterInsert
sampleSet

SmapleSet.update(with: data)
SampleSet


Set#2
Comparing Sets
var a: Set = [1, 2, 3, 4, 5, 6, 7, 8, 9]
var b: Set = [1, 3, 5, 7, 9]
var c: Set = [2, 4, 6, 8, 10]
let d: Set = [1, 7, 5, 9, 3]

a == b
a != b

b == d

b.elementsEqual(d)

a.isSubset(of: a)
a.isStrictSubset(of: a)

b.isSubset(of: a)
b.isStrictSubset(of: a)

a.isSubset(of: a)
a.isStrictSubset(of: a)

a.isSubset(of: b)
a.isStrictSubset(of: b)

a.isSubset(of: c)
a.isStrictSubset(of: c)


a.isDisjoint(with: b)
a.isDisjoint(with: c)
b.isDisjoint(with: c)



Combining Setsa = [1, 2, 3, 4, 5, 6, 7, 8, 9]
b = [1, 3, 5, 7, 9]
c = [2, 4, 6, 8, 10]

var result = b.union(c)

result = b.union(a)
b.formUnion(c)
b




###################2021.07.10
Dictionary#3
Comparing Dictionaries
let a = ["A": "Apple", "B": "Banana", "C": "City"]
let b = ["A": "Apple", "C": "City", "B": "Banana"]

a == b
a != b

//a.elementsEqual(b) { (lhs, rhs) -> Bool in
//    print(lhs.keym rhs.key)
//    return lhs.key.caseInsensitiveCompare(rhs.key)
//        == .orderedSame &&
//}
let aKeys = a.keys.sorted()
let bKeys = b.keys.sorted()

aKeys.elementsEqual(bKeys) { (lhs, rhs) -> Bool in
    guard lhs.caseInsensitiveCompare(rhs)
            == .orderedSame else {
        return false
    }
    
    guard let lv = a[lhs], let rv = b[rhs],
          lv.caseInsensitiveCompare(rv) == .orderedSame
    else {
        return false
    }
    return true
}



Finding Elements
//검색구현
//words?????????????
words = ["A": "Apple", "B": "Banana", "C": "City"]

let c: ((String, String)) -> Bool in = {
    $0.0 == "B" || $0.1.contains("i")
}

words.contains(where: c)

let r = words.first(where: c)
r?.key
r?.value


words.filter(c)

###################2021.07.09
Dictionary#1
Dictionary
Dictionary Literal

var dict = ["A": "Apple", "B": "Bnana"]
dict = [:]


Dictionary Type
//정식문법let dict1: Dictionary<String, Int>
//단축let dict2: [String: Int]


Creating a Dictionary
let words = ["A": "Apple", "B": "Banana", "C": "City"]

let emptyDict: [String: String] = [:]

let emptyDict2 = [String: String]()
let emptyDict3 = Dictionary<String, String>()


Inspecting a Dictionary
//저장된 요소의 숫자를 확인
words.count
words.isEmpty


Accessing Keys and Values
//저장되어있는 요소의 접근
words["A"]
words["Apple"]
//key를 통해 접근하기 때문에 애플은 인식못함

let a = words["E"]
let b = words["E", default: "Empty"]


for k in words.keys {
    print(k)
}

for v in words.values {
    print(v)
}

let keys = Array(words.keys)
let values = Array(words.values)

Dictionary#2
Adding Keys and Values
//새로운 요소를 추가하고 삭제하는 방법

var words = [String: String]()

words["A"] = "Apple"
words["B"] = "Banana"

words.count
words


words["B"] = "Ball"

words.count
words

//Key가 존재한다면 새로운 값을, 기존 값이 있다면 변경


words.updateValue("City", forKey: "C")

words.updateValue("Circle", forKey: "C")

//Insert + Update = Upsert



Removing Keys and Values
//요소를 삭제하는 방법
words
words["B"] = nil

words

words["Z"] = nil

//삭제하고 삭제된 값을 보여줌
words.removeValue(forKey: "A")
//삭제되서 nil
words.removeValue(forKey: "A")


//전체요소 삭제
words.removeAll()







###################2021.07.08
Dictionary


Collection
Array#1
Array Basics
Creating an Array

let nums = [1, 2, 3]

let emptyArray: [Int] = []

let emptyArray2 = Array<Int>()
let empty3 = [Int]()

let zeroArray = [Int](repeating: 0, count: 10)




Inspecting an Array

nums.count

nums.count == 0

nums.isEmpty
emptyArray.isEmpty




Accessing Elements

//배열인덱스는 0부터 시작
let fruits = ["Apple", "Banana", "Mellon"]
fruits[0]
fruits[2]

fruits[0...1]

fruits[fruits.startIndex]
fruits[fruits.index(before: fruits.endIndex)]

fruits.first
fruits.last

emptyArray.first
emptyArray.last

//emptyArray[0]

Array#2
Adding Elements

//새로운 요소를 추가 삭제하고 싶다면 var
//let으로 설정한다면 추가삭제 불가
var alphabet = ["A", "B", "C"]
alphabet.append("E")

//2개 이상의 요소를 추가하고 싶다면
alphabet.append(contentsOf: ["F", "G"])

//중간에 넣을때
alphabet.insert("D", at: 3)
alphabet.insert(contentsOf: ["a", "b", "c"], at: 0)

alphabet[0...2] = ["x", "y", "z"]
alphabet

alphabet.replaceSubrange(0...2, with: ["a", "b", "c"])
alphabet

alphabet[0...2] = ["z"]
alphabet

alphabet[0..<1] = []
alphabet


Removing Elements

//요소를 삭제하는 방법
alphabet = ["A", "B", "C", "D", "E", "F", "G"]
//하나의 요소를 삭제
alphabet.remove(at: 2)
alphabet

alphabet.removeFirst()
alphabet

alphabet.removeFirst(2)
alphabet

alphabet.removeAll()

alphabet.popLast()

alphabet = ["A", "B", "C", "D", "E", "F", "G"]
alphabet.popLast()
alphabet

alphabet.removeSubrange(0...2)
alphabet

alphabet[0...2] = []
alphabet




Array#3
Comparing Arrays

//배열에서 비교,검색,정렬
let a = ["A", "B", "C"]
let b = ["a", "b", "c"]

a == b
a != b

a.elementsEqual(b)

a.elementsEqual(b) { (lhs, rhs) -> Bool in
    return lhs.caseInsensitiveCompare(rhs)
        == .orderedSame
}




Finding Elements

let nums = [1, 2, 3, 1, 4, 5, 2, 6, 7, 5, 0]
nums.contains(1)
nums.contains(8)

nums.contains { (n) -> Bool in
    return n % 2 == 0
}

nums.first { (n) -> Bool in
    return n % 2 == 0
}

nums.firstIndex { (n) -> Bool in
    return n % 2 == 0
}

nums.firstIndex(of: 1)

nums.lastIndex(of: 1)




Sorting on Array

//배열을 정렬
//sort = 배열을 직접 정렬
//sorted = 정렬된 새로운 배열을 리턴

nums.sorted()
nums

nums.sorted { (a, b) -> Bool in
    return a > b
}

nums.sorted().reversed()
[Int](nums.sorted().reversed())

var mutableNums = nums

mutableNums.sort()
mutableNums.reverse()

//위치바꾸기
mutableNums
mutableNums.swapAt(0, 1)
//렌덤으로 순서바꾸기
mutableNums.shuffle()


###################2021.07.07
Structure
###################2021.07.06
String Options #1
Case Insensitive Option
"A" == "a"
"A".caseInsensitiveCompare("a") == .orderedSame

"A" .compare("a", options: [.caseInsensitive])
    == .orderedSame

NSString.CompareOptions
//cont + Commd + click


Literal Option
let a = "\u{D55C}"
let b = "\u{1112}\u{1161}\u{11AB}"

a == b
a.compare(b) == .orderedSame

a.compare(b, options: [.literal]) == .orderedSame



Backwards Option
let korean = "행복하세요"
let english = "Be happy"
let arabic = "كن سعيدا"

if let range = english.range(of: "p", options: [.backwards]) {
    english.distance(from: english.startIndex, to:
                        range.lowerBound)
}
//backward는 문자열의 검색 방향을 바꾸는 옵션


Anchored Option
let str = "Swift Programing"

if let result = str.range(of: "Swift") {
    print(str.distance(from: str.startIndex, to:
                        result.lowerBound))
} else {
    print("not found")
}


if let result = str.range(of: "Swift", options:
                            [.backwards]) {
    print(str.distance(from: str.startIndex, to:
                        result.lowerBound))
} else {
    print("not found")
}

if let result = str.range(of: "Swift", options:
                            [.anchored]) {
    print(str.distance(from: str.startIndex, to:
                        result.lowerBound))
} else {
    print("not found")
}

if let result = str.range(of: "Swift", options:
                            [.anchored, .backwards]) {
    print(str.distance(from: str.startIndex, to:
                        result.lowerBound))
} else {
    print("not found")
}

str.lowercased().hasPrefix("swift")

if let _ = str.range(of: "swift", options:
                        [.anchored, .caseInsensitive]) {
    print("same prefix")
}


###################2021.07.05
###################2021.07.04
String Editing #2
###########Replacing Substrings
//문자열의 일부를 교체 및 삭제하는 방법
var str = "Hello, Objective-C"
if let range = str.range(of: "Objective-C") {
    str.replaceSubrange(range, with: "Swift")
}
str

if let range = str.range(of: "Hello") {
    _ = str.replacingCharacters(in: range, with: "Hi")
}

var s = str.replacingOccurrences(of: "Swift", with: "Awesome Swift")
s

s = str.replacingOccurrences(of: "swift", with: "Awesome Swift")

s
//대소문자 구분



#############Removing Substrings
//특정 문자나 범위 삭제 방법
var str = "Hello Awesome Swift!!!"

let lastCharIndex = str.index(before: str.endIndex)

var removed = str.remove(at: lastCharIndex)

removed
str

removed = str.removeFirst()
removed
str

str.removeFirst(2)
str

str.removeLast(2)
str

if let range = str.range(of: "Awesome") {
    str.removeSubrange(range)
str
}

str.removeAll()
str

str.removeAll(keepingCapacity: true)


str = "Hello, Awesome Swift!!!"

var substr = str.dropLast()

substr = str.dropLast(3)



String Editing #1
Appending Strings and Characters

//문자열을 편집하는 방법
//문자열 뒤에 새로운 문자열을 연결하는 방법

//[
//var str = "Hello"
//str.append(", ")
//str
//
//let s = str.appending("Swift")
//str
//s
//s.appending("!!")
//
//"File size is ".appendingFormat("%.1f", 12.3456)
//]

var str = "Hello Swift"

str.insert(",", at: str.index(str.startIndex, offsetBy: 5))

if let sIndex = str.firstIndex(of: "S") {
   str.insert(contentsOf: "Awesome", at: sIndex)
}
str


###################2021.07.03_3
SubString
let str = "Hello, Swift"
let l = str.lowercased()

var first = str.prefix(1)
//서브 스트링은 원본 문자열의 메모리를 공유한다

first.insert("!", at: first.endIndex)

str
first

let newStr = String(str.prefix(1))
//문자열에서 특정 범위를 추출하는 방법
//오류메세지 : Deprecated = 나중에 버젼 바뀌면 사용 안된다는 메세지

//let s = str[str.startIndex ..< str.index(str.startIndex, offsetBy: 2)]
//위 아래 같은 코드
let s = str[..<str.index(str.startIndex, offsetBy: 2)]

//1. 원본메모리를 공유한다
//2. s변수의 저장된 문자열을 바꾸지않는다면 새로운 문자열은 생성되지 않는다
//3. s변수의 저장된 문자열을 바꾸면 그 시점에 새로운 문자열 생성된다
//4. 직접 새로운 문자열을 생성하고 싶다면, String 생성자를 사용한다.

str [str.index(str.startIndex, offsetBy: 2)...]

let lower = str.index(str.startIndex, offsetBy: 2)
let upper = str.index(str.startIndex, offsetBy: 5)
str[lower ... upper]


###################2021.07.03_2  
String Basics  
//문자열 처리 테크닉

var str = "Hello, Swift String"
var emptystr = ""
emptystr = String()

let a = String(true)
//문자열 "true" ""로 확인

let b = String(12)
//숫자 12가 아닌 문자열 12
let c = String(12.34)

let d = String(str)

let hex = String(123, radix: 16)
//16진수
let octal = String(123, radix: 8)
//8진수
let binary = String(123, radix: 2)
//2진수

//문자열을 초기화할 때 그냥 지우는게 아니라 특정 문자를 원하는 개수만큼 채워서 초기화하는 방법
let reapeatStr = "💀"
let repeatStr = String(repeating: "💀", count: 7)
let unicode = "\u{1f44f}"

let e = "\(a) \(b)"
let f = a + b
//공백넣기" " ->   let f = a + " " + b
str  += "!!"

//문자열 개수 확인
str.count
str.count == 0
str.isEmpty

str == "Apple"
"apple" != "Apple"
"apple" < "Apple"

//대소문자 변환
str.lowercased()
str.uppercased()
str
//첫 문자를 대문자로 변환
str.capitalized
"apple ipad" .capitalized

for char in "Hello" {
    print(char)
}

//랜덤으로 뽑기
let num = "1234567890"
num.randomElement()

//섞어서 문자열로 배열하기
num.shuffled()


###################2021.07.03_1
String Indices
//문자열 인덱스

let str = "Swift"

let firstCh = str[str.startIndex]
print(firstCh)

let lastCharIndex = str.index(before: str.endIndex)
let lastCh = str[lastCharIndex]
print(lastCh)

let secondCharIndex = str.index(after: str.startIndex)
let secondCh = str[secondCharIndex]
print(secondCh)

var thirdCharIndex = str.index(str.startIndex, offsetBy: 2)
var thirdCh = str[thirdCharIndex]
print(thirdCh)

thirdCharIndex = str.index(str.endIndex, offsetBy: -3)
thirdCh = str[thirdCharIndex]
print(thirdCh)

if thirdCharIndex < str.endIndex && thirdCharIndex >=
    str.startIndex {
    
}


###################2021.07.02
_String Substring
_String Editing #1
_String Editing #2
_String Comparison
_String Searching
_String Options #1
_String Options #2


###################2021.07.01
_New String Interpolation
_String Indices
_String Index
_String Basics


2021.06.28
###################String Interpolation
var str = "12.34KB"

let size = 12.34
str = String(size) + "KB"
//문자열을 더블로 바꿀 수 없음, 더블을 문자열로 바꿈
// Interpolating = 문자열 삽입 or 보관

str = "\(size)KB"
//단점 - 직관적으로 문자열을 구상할 수 있지만, 원하는 포맷을 지정할 수 없음

-Format Specifier
//원하는 포맷 지정
str = String(format: "%.1fKB", size)
//.1은 소숫점 1자리, f는 실수

String(format: "Hello, %@", "Swift")
//%@문자는 문자열과 참조형식을 대체시 사용
       String(format: "%d", 12)
//정수는 %d 사용(대소문자 상관없음,보통 소문자 사용)     정수만 대체
    String(format: "%010.3f", 12.34)

String(format: "[%d]", 123)
String(format: "[%10d]", 123)
String(format: "[%-10d]", 123)

let firstName = "yeo jin"
let lastName = "yoon"

let korFormat = "그녀의 이름은 %@ %@ 입니다."
let engFormat = "Her name is %@ %@."
String(format: korFormat, firstName, lastName)
String(format: engFormat, firstName, lastName)

//%2$@ %1$@ 순서변경
//let korFormat = "그녀의 이름은 %2$@ %1$@ 입니다."
//let engFormat = "Her name is %1$@ %2$@."
//
//String(format: korFormat, firstName, lastName)
//String(format: engFormat, firstName, lastName)


//\는 두번
str = "\\"
print(str)

print("A\tb")
// \t는 탭 추가

print("c\nD")
// \n 줄바꿈

print("\"Hello\" He said.")
//추가 \"

#################Multiline String Literal
// /n 줄바꿈 = 이스케이프시퀀스
//싱글라인리터럴
let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod \ntempor incididunt ut labore et dolore magna aliqua."

//멀티라인리터럴
let multiline = """
        Lorem ipsum dolor sit amet,\
        consectetur adipiscing elit, sed do eiusmod
            tempor incididunt ut labore et dolore magna aliqua.
    """
//단독으로 """ 작성,, 들여쓰기, 동일선상 및 좌측에 위치해야함 , 멀티라인리터럴에서 \사용시 줄바꿈 취소




###################Strings and character
--Strings and Characters
let s = "String"
let c: Character = "C"

let emptyChar: Character = " "

let emptyString = " "
//문자열은 길이를 기준으로 빈 문자열을 판단
//빈 문자열은 -> let emptyString = ""
emptyString.count

let emptyString2 = String()


-String Types
var nsstr: NSString = "str"

let swiftStr: String = nsstr as String
//as String = 타입캐스팅
nsstr = swiftStr as NSString

-Mutability
//문자열의 가변성
let immutableStr = "str"
//immutableStr = "new str"

var mutableStr = "str"
mutableStr = "new str"

-Unicode
let str = "Swift String"

str.utf8
str.utf16

//cont + commd + spacebar = 이모티콘
var thumbUP = "👍"

thumbUP = "\u{1F44D}"
//👍
//올린 엄지
//유니코드: U+1F44D, UTF-8: F0 9F 91 8D
//유니코드값으로 이모티콘 삽입 가능

########################//  튜플매칭?!
-Tuple Matching

let resolution = (1920.0, 1080.0)

if resolution.0 == 3840 && resolution.1 == 2160 {
    print("4K")
}

switch resolution {
case let(w, h) where w / h == 16.0 / 9.0:
    print("16:9")
case (_, 1080):
    print("1080p")
case (3840...4096, 2160):
    print("4K")
default:
    break
}


2021.06.27
Tuple
-Tuple Decomposition
-//분해

let data = ("<html>", 200, "OK", 12.34)

//let body = data.0
//let code = data.1
//let messaage = data.2
//let size = data.3

let (body, code, message, _) = data



2021.06.26 15:49
git hub



2021.06.26
Tuple + test

## This is Title

- list 1
- list 2
- list 3
- list 4
