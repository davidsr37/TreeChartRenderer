//
//  UIColor+Extension.swift
//  RenderTree
//
//  Created by David Rogers on 4/16/24.
//

import UIKit

extension UIColor {
  /// Generates a random UIColor.
  /// - Returns: A UIColor with random red, green, blue, and alpha values.
  static func random() -> UIColor {
    return UIColor(
      red: .random(in: 0...1),
      green: .random(in: 0...1),
      blue: .random(in: 0...1),
      alpha: 1.0
    )
  }
}
