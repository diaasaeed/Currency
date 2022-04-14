//
//  HistoricalVC.swift
//  Currency
//
//  Created by Diaa saeed on 4/14/22.
//

import UIKit
import RxCocoa
import RxSwift

class HistoricalVC: UIViewController {
    
    //MARK: - outlet
     @IBOutlet var HistoricalTableView: UITableView!
    
    //MARK: - variables
    var viewModel = HistoricalViewModel()
    var ConvertCurrencyData = MyConvertCurrencyOBJ() // array of country code
    let disposeBag = DisposeBag()
    var lastThreeDays = [String]()
    var popularCurrency = [String]()
    
    //MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setXIB()
        
        viewModel.ConvertCurrencyData = ConvertCurrencyData
        viewModel.viweDidload()
        subscribeHistorical()
        subscribepopularCurrency()
        HistoricalTableView.delegate = self
        HistoricalTableView.dataSource = self
    }
 
    //MARK: - functions
    func setXIB(){
        self.HistoricalTableView.register(UINib(nibName: "CurrencyHistoricalCell", bundle: nil), forCellReuseIdentifier: "CurrencyHistoricalCell")
        
        self.HistoricalTableView.register(UINib(nibName: "ChartCell", bundle: nil), forCellReuseIdentifier: "ChartCell")
    }
    
    func subscribeHistorical(){
        viewModel.LastCurrencyObservable.subscribe(onNext: { (value) in
            print("Data is last three" , value.count)
            self.lastThreeDays = value
            self.HistoricalTableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    
    func subscribepopularCurrency(){
        viewModel.otherCurrenciesObservable.subscribe(onNext: { (value) in
            print("Data is  other cuntries" , value.count)
            self.popularCurrency = value
        }).disposed(by: disposeBag)
    }
    
}

//MARK: - error
extension HistoricalVC:ErrorProtocol{
    func featching(error: String) {
        self.showAlert(withTitle: false, msg: error, compilition: nil)
    }
}
