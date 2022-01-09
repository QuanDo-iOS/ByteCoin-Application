//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Quan's Macbook on 09/01/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currency : String
    let bitcoin : Double
    
    var bitcoinString : String {
        return String(format: "%.2f", bitcoin)
    }
}
