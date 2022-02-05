//
//  Date+FormatDate.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
extension Date{
    func prettyDate() -> String{
        let format = DateFormatter()
        format.dateFormat = "d/MM/yyyy"
        return format.string(from: self)
    }
}
