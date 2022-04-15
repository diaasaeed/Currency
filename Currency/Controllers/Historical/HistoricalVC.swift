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

    //MARK: - view did load
    override func viewDidLoad() {
        super.viewDidLoad()
 
        callAllFunction()
    }
 
    //MARK: - functions
    func callAllFunction(){
        setXIB()
        viewModel.ConvertCurrencyData = ConvertCurrencyData
        viewModel.viweDidload()
        subscribeTableView()
        subscribeErrorMessage()
     }
    
    func setXIB(){
        self.HistoricalTableView.register(UINib(nibName: "CurrencyHistoricalCell", bundle: nil), forCellReuseIdentifier: "CurrencyHistoricalCell")
        self.HistoricalTableView.register(UINib(nibName: "ChartCell", bundle: nil), forCellReuseIdentifier: "ChartCell")
    }
    
    //error
    func subscribeErrorMessage(){
        self.viewModel.errorObservable.subscribe(onNext: { (message) in
            self.showActionAlert(msg: message)
        }).disposed(by: disposeBag)
    }
    
    
    func subscribeTableView(){
        viewModel.HistorcalObservable.bind(to: self.HistoricalTableView.rx.items){(tv, row, item) -> UITableViewCell in
            let indexPath = IndexPath(row: row, section: 0)
            
               if row == 0 {
                let chart = self.HistoricalTableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartCell

                chart.chartCurrency.xElements = NSMutableArray(array: item.ChartDate ?? [])
                chart.chartCurrency.yElements = NSMutableArray(array: item.valueChart ?? [])
                chart.chartCurrency.chartTitle = "\(self.ConvertCurrencyData.fromCountry ?? "") for last three days"
                 chart.chartCurrency.drawChart()
                
                return chart
               }else{
                let cell = self.HistoricalTableView.dequeueReusableCell(withIdentifier: "CurrencyHistoricalCell", for: indexPath) as! CurrencyHistoricalCell
                
                // last three days
                var lastThreeDays = String()
                let countLast = item.lastCurrency?.count ?? 0
                for var i in 0..<countLast {
                    lastThreeDays+="\(item.lastCurrency?[i] ?? "")\n\n"
                    i+=1
                }
                cell.lastThreeDayLable.text = lastThreeDays
                cell.baseCurrencyLable.text = "Historical data for last 3 days for currency \(self.ConvertCurrencyData.amount ?? 0) \(self.ConvertCurrencyData.fromCountry ?? "") equals"
                
                // popular currency
                var popular = String()
                for i in item.popularCurrencies ?? []{
                    popular+="\(i)\n"
                }
                cell.popularCurrencyLable.text = popular
                return cell
               }

        }.disposed(by: disposeBag)
     }
}

 
