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
    var chartDate = [Double]()
    var chartValue = [Double]()
    
    //MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setXIB()
        
        viewModel.ConvertCurrencyData = ConvertCurrencyData
        viewModel.viweDidload()
        subscribeHistorical()
        subscribepopularCurrency()
        subscribeChartValue()
        subscribeChartDate()
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
            self.lastThreeDays = value
            self.HistoricalTableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    
    func subscribepopularCurrency(){
        viewModel.otherCurrenciesObservable.subscribe(onNext: { (value) in
            self.popularCurrency = value
        }).disposed(by: disposeBag)
    }
 
    func subscribeChartDate(){
        viewModel.ChartDateObservable.subscribe(onNext: { (value) in
            self.chartDate = value
        }).disposed(by: disposeBag)
    }
    
    func subscribeChartValue(){
        viewModel.ChartvalueObservable.subscribe(onNext: { (value) in
            self.chartValue = value
        }).disposed(by: disposeBag)
    }
}

//MARK: - error
extension HistoricalVC:ErrorProtocol{
    func featching(error: String) {
        self.showAlert(withTitle: false, msg: error, compilition: nil)
    }
}
