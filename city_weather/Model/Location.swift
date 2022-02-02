//
//  Location.swift
//  city_weather
//
//  Created by Alejandro Guerra, on 1/31/22.
//

import Foundation
struct Location : Codable {
    let consolidated_weather : [ConsolidatedWeather]?
    let time : String?
    let sun_rise : String?
    let sun_set : String?
    let timezone_name : String?
    let parent : Parent?
    let sources : [Sources]?
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
        case parent = "parent"
        case sources = "sources"
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
        parent = try values.decodeIfPresent(Parent.self, forKey: .parent)
        sources = try values.decodeIfPresent([Sources].self, forKey: .sources)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        location_type = try values.decodeIfPresent(String.self, forKey: .location_type)
        woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
        latt_long = try values.decodeIfPresent(String.self, forKey: .latt_long)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
    }

}
