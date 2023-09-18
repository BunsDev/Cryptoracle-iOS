//
//  CryptoCurrencies.swift
//  Cryptoracle
//
//  Created by Daniel on 17/09/23.
//

import Foundation

struct Cryptocurrency: Identifiable, Decodable {
    var id: String
    var name: String
    var symbol: String
    var current_price: Double
    var last_updated: String
    var image: String
    var total_volume: Double
    var high_24h: Double
    var low_24h: Double
    var price_change_24h: Double
    var market_cap: Double
}
