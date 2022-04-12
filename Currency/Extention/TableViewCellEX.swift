//
//  TableViewCellEX.swift
//  employee
//
//  Created by Ahmed on 4/7/21.
//

import UIKit

extension UITableViewCell{
    
    /// set animation to cell that slide horizontali
    /// - Parameters:
    ///   - translationX: the initiate transform point is the width of the tableView
    ///   - row: the index of the cell
    func slideAnimation(translationX: CGFloat, row: Int){
        let value = translationX * (app_lang == "en" ? -1:1)
        self.transform = CGAffineTransform(translationX: value, y: 0)
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0.02 * Double(row),
            options: [.curveEaseInOut],
            animations: {
                self.transform = CGAffineTransform(translationX: 0, y: 0)
            })
    }
    
    
    /// fade animation for the cell
    /// - Parameter row: the index of cell
    func fadeAnimation(row: Int){
        self.alpha = 0

        UIView.animate(
            withDuration: 0.2,
            delay: 0.02 * Double(row),
            animations: {
                self.alpha = 1
        })
    }
}


