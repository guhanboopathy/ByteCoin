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
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(K.baseURL)\(currency)\(K.apiKey)"
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
