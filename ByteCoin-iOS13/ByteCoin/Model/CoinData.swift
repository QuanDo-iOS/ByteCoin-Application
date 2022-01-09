//
//  CoinData.swift
//  ByteCoin
//
//  Created by Quan's Macbook on 09/01/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData : Codable {
    let asset_id_base : String
    let asset_id_quote : String
    let rate : Double
}
