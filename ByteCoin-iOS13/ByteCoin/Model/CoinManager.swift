//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(coinModel : CoinModel)
    func didFailWithError(error : Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "4E7D2FD0-0425-4D91-B38A-0F5D65CBDEA2"
    
    let currencyArray = ["AUD","BRL","CAD","EUR","GBP","HKD","IDR","ILS","INR","JPY"
                        ,"MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate : CoinManagerDelegate?
    
    func getCoinPrice(for currency : String){
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
        if let url = URL(string : urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let coin = self.parseData(coinData: safeData){
                        self.delegate?.didUpdateCurrency(coinModel: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseData(coinData : Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CoinData.self, from: coinData)
            
            let currency = decodeData.asset_id_quote
            let rate  = decodeData.rate
            
            return CoinModel(currency: currency, bitcoin: rate)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
