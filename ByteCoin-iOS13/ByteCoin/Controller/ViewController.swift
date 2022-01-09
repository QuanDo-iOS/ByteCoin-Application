//
//  ViewController.swift
//  ByteCoin
//
//  Created by QuanDo on 09/01/2022.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!

    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}

extension ViewController : UIPickerViewDataSource {
    // how many columns we want in our picker.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // how many rows this picker should have
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.coinManager.currencyArray.count
    }
}

extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

extension ViewController : CoinManagerDelegate {
    func didUpdateCurrency(coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coinModel.bitcoinString
            self.currencyLabel.text = coinModel.currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
