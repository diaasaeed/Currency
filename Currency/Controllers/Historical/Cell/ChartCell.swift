//
//  ChartCell.swift
//  Currency
//
//  Created by Diaa saeed on 4/14/22.
//

import UIKit
import HCLineChartView

class ChartCell: UITableViewCell {

    @IBOutlet var chartCurrency: HCLineChartView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
   
    }
 
    
}
