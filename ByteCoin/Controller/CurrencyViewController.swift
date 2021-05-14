//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    var coinManager = CoinManager()
    var selectedCurrency:String?
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}
extension CurrencyViewController: updateUIDelegate {
    func handleError(_ error: Error) {
        print(error)
    }
    
    func updateCurreny(_ rate: Double) {
        var temp: String {
            return String(format: "%.0f", rate)
        }
        DispatchQueue.main.async {
            self.currencyLabel.text = self.selectedCurrency!
            self.bitCoinLabel.text = temp
        }
        
    }
    
    
}

