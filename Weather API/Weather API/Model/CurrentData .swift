//
//  CurrentData .swift
//  Weather API
//
//  Created by Abul Kashem on 3/11/22.
//

import Foundation

struct CurrentData: Codable{
    let last_updated : String
    let temp_c : Float
    let wind_kph : Float
    let humidity : Int
    
    
}
