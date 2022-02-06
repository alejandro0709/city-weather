//
//  Location.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 1/31/22.
//

import Foundation
import CoreData
struct Location : Codable {
    let consolidated_weather : [ConsolidatedWeather]?
    let time : String?
    let sun_rise : String?
    let sun_set : String?
    let timezone_name : String?
    let title : String?
    let location_type : String?
    let woeid : Int?
    let latt_long : String?
    let timezone : String?

    enum CodingKeys: String, CodingKey {

        case consolidated_weather = "consolidated_weather"
        case time = "time"
        case sun_rise = "sun_rise"
        case sun_set = "sun_set"
        case timezone_name = "timezone_name"
        case title = "title"
        case location_type = "location_type"
        case woeid = "woeid"
        case latt_long = "latt_long"
        case timezone = "timezone"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        consolidated_weather = try values.decodeIfPresent([ConsolidatedWeather].self, forKey: .consolidated_weather)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        sun_rise = try values.decodeIfPresent(String.self, forKey: .sun_rise)
        sun_set = try values.decodeIfPresent(String.self, forKey: .sun_set)
        timezone_name = try values.decodeIfPresent(String.self, forKey: .timezone_name)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        location_type = try values.decodeIfPresent(String.self, forKey: .location_type)
        woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
        latt_long = try values.decodeIfPresent(String.self, forKey: .latt_long)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
    }
    
    init(from dbEntity: NSManagedObject){
        if let setValue = dbEntity.value(forKey: CodingKeys.consolidated_weather.rawValue) as? NSSet,
            let cwList = setValue.allObjects as? [ConsolidatedWeatherEntity]{
            consolidated_weather = cwList.map({ entity in
                ConsolidatedWeather.init(from: entity)
            })
        } else {
            consolidated_weather = []
        }
        
        time = dbEntity.value(forKey: CodingKeys.time.rawValue) as? String
        sun_rise = dbEntity.value(forKey: CodingKeys.sun_rise.rawValue) as? String
        sun_set = dbEntity.value(forKey: CodingKeys.sun_set.rawValue) as? String
        timezone_name = dbEntity.value(forKey: CodingKeys.timezone_name.rawValue) as? String
        title = dbEntity.value(forKey: CodingKeys.title.rawValue) as? String
        location_type = dbEntity.value(forKey: CodingKeys.location_type.rawValue) as? String
        woeid = dbEntity.value(forKey: CodingKeys.woeid.rawValue) as? Int
        latt_long = dbEntity.value(forKey: CodingKeys.latt_long.rawValue) as? String
        timezone = dbEntity.value(forKey: CodingKeys.timezone.rawValue) as? String
    }
    
    init(title: String, woeid: Int){
        self.title = title
        self.woeid = woeid
        consolidated_weather = []
        time = ""
        sun_rise = ""
        sun_set = ""
        timezone_name = ""
        location_type = ""
        latt_long = ""
        timezone = ""
    }

}
