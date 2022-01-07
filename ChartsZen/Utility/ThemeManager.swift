//
//  ThemeManager.swift
//  ChartsZen
//
//  Created by mac on 05/01/22.
//

import Foundation
import UIKit

struct ThemeManager {
    static func generateRandomColor() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0)
    }
}
