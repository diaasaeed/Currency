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
            let chart = self.HistoricalTableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartCell
            return chart
        }else{
            let cell = self.HistoricalTableView.dequeueReusableCell(withIdentifier: "CurrencyHistoricalCell", for: indexPath) as! CurrencyHistoricalCell
            
            var lastThreeDays = String()
            for var i in 0..<self.lastThreeDays.count{
                lastThreeDays+="\(self.lastThreeDays[i])\n\n"
                i+=1
            }
            cell.lastThreeDayLable.text = lastThreeDays
            cell.baseCurrencyLable.text = "\(self.ConvertCurrencyData.amount ?? 0) \(self.ConvertCurrencyData.fromCountry ?? "") equals"
            
            var popular = String()
            for i in self.popularCurrency{
                popular+="\(i)\n"
            }
            cell.popularCurrencyLable.text = popular
            return cell
        }
    }
    
}

