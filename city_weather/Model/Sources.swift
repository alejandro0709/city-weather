//
//  Sources.swift
//  city_weather
//
//  Created by Alejandro Guerra, DSpot on 1/31/22.
//

import Foundation
struct Sources : Codable {
    let title : String?
    let slug : String?
    let url : String?
    let crawl_rate : Int?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case slug = "slug"
        case url = "url"
        case crawl_rate = "crawl_rate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        crawl_rate = try values.decodeIfPresent(Int.self, forKey: .crawl_rate)
    }

}
