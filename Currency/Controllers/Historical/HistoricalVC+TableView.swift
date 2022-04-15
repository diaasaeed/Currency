//
//  HistoricalVC+TableView.swift
//  Currency
//
//  Created by Diaa saeed on 4/14/22.
//

import Foundation
import UIKit
extension HistoricalVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // chart
            let chart = self.HistoricalTableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartCell

            chart.chartCurrency.xElements = NSMutableArray(array: self.chartDate)
            chart.chartCurrency.yElements = NSMutableArray(array: self.chartValue)
            chart.chartCurrency.chartTitle = "\(self.ConvertCurrencyData.fromCountry ?? "") for last three days"
             chart.chartCurrency.drawChart()
            
            return chart
            
        }else{
            let cell = self.HistoricalTableView.dequeueReusableCell(withIdentifier: "CurrencyHistoricalCell", for: indexPath) as! CurrencyHistoricalCell
            
            // last three days
            var lastThreeDays = String()
            for var i in 0..<self.lastThreeDays.count{
                lastThreeDays+="\(self.lastThreeDays[i])\n\n"
                i+=1
            }
            cell.lastThreeDayLable.text = lastThreeDays
            cell.baseCurrencyLable.text = "Historical data for last 3 days for currency \(self.ConvertCurrencyData.amount ?? 0) \(self.ConvertCurrencyData.fromCountry ?? "") equals"
            
            // popular currency
            var popular = String()
            for i in self.popularCurrency{
                popular+="\(i)\n"
            }
            cell.popularCurrencyLable.text = popular
            return cell
        }
    }
    
}

