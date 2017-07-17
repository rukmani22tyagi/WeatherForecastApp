//
//  Extensions.swift
//  WeatherForecastingApp
//
//  Created by Rukmani  on 17/07/17.
//  Copyright © 2017 rukmani. All rights reserved.
//

import Foundation

extension Date {
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    func getTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
}

