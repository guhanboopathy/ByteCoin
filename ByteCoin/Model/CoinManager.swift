//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol updateUIDelegate {
    func handleError(_ error: Error)
    func updateCurreny(_ rate: Double)
}
struct CoinManager {
    var delegate: updateUIDelegate?
   // let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
   // let apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let url = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    func getCoinPrice(for currency: String) {
        let urlString = "\(url)\(currency)?apikey=59FBF27B-DF99-4EF0-BEA4-534856A6FB81"
        print(urlString)
        handleURL(with: urlString)
    }
    func handleURL(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.handleError(error!)
                    
                }
                else if data != nil {
                    if let safeData = data {
                        if let rate = parseJSON(safeData){
                            print(rate)
                            delegate?.updateCurreny(rate)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ currencyData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinModel.self, from: currencyData)
            return decodedData.rate
        } catch {
            delegate?.handleError(error)
        }
        return nil
    }
}
