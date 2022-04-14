//
//  ConvertCurrencyVC+PickerView.swift
//  Currency
//
//  Created by Diaa saeed on 4/14/22.
//

import Foundation
import UIKit


//MARK: - picker View
extension ConvertCurrencyVC {
    func pickerViewTap(){
        pickerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        pickerView.setValue(UIColor.black, forKey: "textColor")
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 200)
        self.view.addSubview(pickerView)
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 50))
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.onDoneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        self.view.addSubview(toolBar)
    }
    
    @objc func cancelTapped() {
        toolBar.removeFromSuperview()
        pickerView.removeFromSuperview()
    }
    
    @objc func onDoneButtonTapped() {
        viewModel.indexCurrencySelected = self.rowSelected
        viewModel.getCountryTitle()
        toolBar.removeFromSuperview()
        pickerView.removeFromSuperview()
        
        if currencyType == .to{
            self.currencyToTF.text = ""
            self.viewModel.countryToIndex = self.rowSelected
            self.currencyFromTF.becomeFirstResponder()
        }else{
            self.viewModel.countryFromIndex = self.rowSelected
        }
    }
}
