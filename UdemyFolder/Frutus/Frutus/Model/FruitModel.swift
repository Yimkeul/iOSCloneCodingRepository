//
//  FruitModel.swift
//  Frutus
//
//  Created by yimkeul on 2023/08/01.
//

import Foundation
import SwiftUI

struct Fruit: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
    var description: String
    var nutrition: [String]
}
