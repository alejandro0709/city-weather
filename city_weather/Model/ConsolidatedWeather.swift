//
//  ConsolidatedWeather.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 1/31/22.
//

import Foundation
struct ConsolidatedWeather : Codable {
    let id : Int?
    let weather_state_name : String?
    let weather_state_abbr : String?
    let wind_direction_compass : String?
    let created : Date?
    let applicable_date : Date?
    let min_temp : Int?
    let max_temp : Int?
    let the_temp : Int?
    let wind_speed : Double?
    let wind_direction : Double?
    let air_pressure : Double?
    let humidity : Int?
    let visibility : Double?
    let predictability : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case weather_state_name = "weather_state_name"
        case weather_state_abbr = "weather_state_abbr"
        case wind_direction_compass = "wind_direction_compass"
        case created = "created"
        case applicable_date = "applicable_date"
        case min_temp = "min_temp"
        case max_temp = "max_temp"
        case the_temp = "the_temp"
        case wind_speed = "wind_speed"
        case wind_direction = "wind_direction"
        case air_pressure = "air_pressure"
        case humidity = "humidity"
        case visibility = "visibility"
        case predictability = "predictability"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        weather_state_name = try values.decodeIfPresent(String.self, forKey: .weather_state_name)
        weather_state_abbr = try values.decodeIfPresent(String.self, forKey: .weather_state_abbr)
        wind_direction_compass = try values.decodeIfPresent(String.self, forKey: .wind_direction_compass)
        
        let createdFormat = DateFormatter()
        createdFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let createdDateText = try values.decodeIfPresent(String.self, forKey: .created){
            created = createdFormat.date(from: createdDateText)
        } else {
            created = nil
        }
    
        let format = DateFormatter()
        format.dateFormat = "yyyy-mm-dd"
        if let dateText = try values.decodeIfPresent(String.self, forKey: .applicable_date) {
            applicable_date = format.date(from: dateText)
        } else {
            applicable_date = nil
        }
        
        min_temp = Int(try round(values.decodeIfPresent(Double.self, forKey: .min_temp) ?? 0))
        max_temp = Int(try round(values.decodeIfPresent(Double.self, forKey: .max_temp) ?? 0))
        the_temp = Int(try round(values.decodeIfPresent(Double.self, forKey: .the_temp) ?? 0))
        
        wind_speed = try values.decodeIfPresent(Double.self, forKey: .wind_speed)
        wind_direction = try values.decodeIfPresent(Double.self, forKey: .wind_direction)
        air_pressure = try values.decodeIfPresent(Double.self, forKey: .air_pressure)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        visibility = try values.decodeIfPresent(Double.self, forKey: .visibility)
        predictability = try values.decodeIfPresent(Int.self, forKey: .predictability)
    }
    
    init(from dbEntity: ConsolidatedWeatherEntity){
        id = Int(dbEntity.id)
        weather_state_name = dbEntity.weather_state_name
        weather_state_abbr = dbEntity.weather_state_abbr
        wind_direction_compass = dbEntity.wind_direction_compass
        created = dbEntity.created
        applicable_date = dbEntity.applicable_date
        min_temp = Int(dbEntity.min_temp)
        max_temp = Int(dbEntity.max_temp)
        the_temp = Int(dbEntity.the_temp)
        wind_speed = dbEntity.wind_speed
        wind_direction = dbEntity.wind_direction
        air_pressure = dbEntity.air_pressure
        humidity = Int(dbEntity.humidity)
        visibility = dbEntity.visibility
        predictability = Int(dbEntity.predictability)
    }

}
