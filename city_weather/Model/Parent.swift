//
//  Parent.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 1/31/22.
//

import Foundation
struct Parent : Codable {
    let title : String?
    let location_type : String?
    let woeid : Int?
    let latt_long : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case location_type = "location_type"
        case woeid = "woeid"
        case latt_long = "latt_long"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        location_type = try values.decodeIfPresent(String.self, forKey: .location_type)
        woeid = try values.decodeIfPresent(Int.self, forKey: .woeid)
        latt_long = try values.decodeIfPresent(String.self, forKey: .latt_long)
    }

}
