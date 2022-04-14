//
//  CurrencyHistoricalCell.swift
//  Currency
//
//  Created by Diaa saeed on 4/14/22.
//

import UIKit

class CurrencyHistoricalCell: UITableViewCell {

    @IBOutlet var lastThreeDayLable: UILabel!
    @IBOutlet var popularCurrencyLable: UILabel!
    
    @IBOutlet var baseCurrencyLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

 
}
