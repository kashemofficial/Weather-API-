//
//  ViewController.swift
//  Weather API
//
//  Created by Abul Kashem on 3/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var updateTimeLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: method calling
        fetchData()
    }
    func fetchData(){
        let url = URL(string:         "https://api.weatherapi.com/v1/current.json?key=65a7aea3e395474187a20653220504&q=bangladesh&aqi=no")
        
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data,response,error) in
            guard let data = data , error == nil else{
                print("Error Occured While Accessing Data with URL")
                return
            }
            
            let responseString = String(decoding: data, as: UTF8.self)
            print("RESPONSE : " + responseString)
             
            var fullWeatherData: WeatherData?
          
            do{
                fullWeatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            }
            catch{
                print("Error Occured While Decoding JSON into Swift Structure\(error)")
            }
            
            DispatchQueue.main.async {
                self.updateTimeLbl.text = "Update : \(fullWeatherData!.current.last_updated)"
                self.regionLbl.text = "Region : \(fullWeatherData!.location.name)"
                self.countryLbl.text = "Country : \(fullWeatherData!.location.country)"
                self.temperatureLbl.text = "Temperature : \(fullWeatherData!.current.temp_c)"
                self.windLbl.text = "Wind : \(fullWeatherData!.current.wind_kph)"
                self.humidityLbl.text = "Humidity : \(fullWeatherData!.current.humidity)"
            }
        })
        
        dataTask.resume()
    }

    @IBAction func refreshData(_ sender: UIButton) {
        fetchData()
    }
}

