//
//  HistoricalVC.swift
//  Currency
//
//  Created by Diaa saeed on 4/14/22.
//

import UIKit

class HistoricalVC: UIViewController {

    var viewModel = HistoricalViewModel()
    var ConvertCurrencyData = MyConvertCurrencyOBJ() // array of country code

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.ConvertCurrencyData = ConvertCurrencyData
        viewModel.viweDidload()
     }
    

 

}

extension HistoricalVC:ErrorProtocol{
    func featching(error: String) {
        self.showAlert(withTitle: false, msg: error, compilition: nil)
    }
}
