//
//  ViewController.swift
//  Currency
//
//  Created by Diaa saeed on 4/12/22.
//

import UIKit
import RxCocoa
import RxSwift

enum typeCurrency {
    case from
    case to
}

class ConvertCurrencyVC: UIViewController{
    
    //MARK: - outlet
    @IBOutlet weak var viewFrom: UIView!
    @IBOutlet weak var fromLable: UILabel!
    @IBOutlet weak var currencyFromTF: UITextField!
    
    @IBOutlet weak var viewTo: UIView!
    @IBOutlet weak var toLable: UILabel!
    @IBOutlet weak var currencyToTF: UITextField!
    @IBOutlet weak var detailBu: UIButton!
    
    //MARK: - variabels
    let disposeBag = DisposeBag()
    var viewModel  = ConvertCurrencyViewModel()
    
    var toolBar = UIToolbar()
    var pickerView  = UIPickerView()
    var currencyType:typeCurrency?
    var rowSelected = 0
    
    //MARK: - viewdidlaod
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyFromTF.keyboardType = .asciiCapableNumberPad
        currencyToTF.isUserInteractionEnabled = false
        self.navigationItem.title = "Convert Currency"
        
        let tapFrom = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom(_:)))
        viewFrom.addGestureRecognizer(tapFrom)
        let tapTo = UITapGestureRecognizer(target: self, action: #selector(self.handleTapTo(_:)))
        viewTo.addGestureRecognizer(tapTo)
        
        currencyFromTF.addTarget(self, action: #selector(fromTFAction(_:)),for: .editingChanged)
        
        pickerView = UIPickerView.init()
        
        //Check internet connection
        if Reachability.isConnectedToNetwork(){
            self.callAllFunctions()
        }else{
            self.showAlert(withTitle: false, msg: "No internet connections", compilition: nil)
        }
    }
    
    
    //MARK: - actions
    @objc func handleTapFrom(_ sender: UITapGestureRecognizer? = nil) {
        currencyType = .from
        pickerViewTap()
        view.endEditing(true)
        pickerView.reloadAllComponents()
        
    }
    
    @objc func handleTapTo(_ sender: UITapGestureRecognizer? = nil) {
        currencyType = .to
        pickerViewTap()
        view.endEditing(true)
        pickerView.reloadAllComponents()
    }
    
    @objc func fromTFAction(_ textField: UITextField) {
        self.viewModel.fromCurrencyValue = Double(self.currencyFromTF.text ?? "") ?? 0.0
        self.viewModel.calculatorCurrency()
    }
    
    
    @IBAction func switchBTN(_ sender: Any) {
        switchCurrency()
    }
    
    @IBAction func detailsBTN(_ sender: Any) {
        view.endEditing(true)
        if Reachability.isConnectedToNetwork(){
            let historical = self.storyboard?.instantiateViewController(withIdentifier: "HistoricalVC") as! HistoricalVC
            historical.ConvertCurrencyData = self.viewModel.myConvertCurrencyOBJ
            self.navigationController?.pushViewController(historical, animated: true)
        }else{
            self.showAlert(withTitle: false, msg: "No internet connections", compilition: nil)
        }
    }
    
    
    //MARK: - funtions
    
    
    func callAllFunctions(){
        viewModel.getCountry()
        SubscribeToResponseAllCurrency()
        SelectRowCurrency()
        subscribeValueCounrty()
        subscribeDefaultValue()
        subscribeTotalCurrency()
    }
    
    //Picekr view 
    func SubscribeToResponseAllCurrency(){
        viewModel.CurrencyModelObservable.asObservable().bind(to: self.pickerView.rx.itemTitles) { (row, element) in
            return element.country ?? ""
        }
        .disposed(by: disposeBag)
    }
    
    func SelectRowCurrency(){
        pickerView.rx.itemSelected
            .subscribe { (event) in
                switch event {
                case .next(let selected):
                    print("You selected #\(selected.row)")
                    self.rowSelected = selected.row
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    // get Selected country title
    func subscribeValueCounrty(){
        self.viewModel.CountryStringObservable.subscribe(onNext: { (value) in
            if self.currencyType == .from {
                self.fromLable.text = value
            }else{
                self.toLable.text = value
            }
        }).disposed(by: disposeBag)
    }
    
    
    //Set default value when open app at frist time
    func subscribeDefaultValue(){
        self.viewModel.DefaultCurrencyDoubleObservable.subscribe(onNext: { (value) in
            self.currencyToTF.text = "\(value.getTwoDigits)" // EGP
            self.currencyFromTF.text = "\(1)" // USD
        }).disposed(by: disposeBag)
        
    }
    
    // Get convert currency
    func subscribeTotalCurrency(){
        self.viewModel.totalCurrencyDoubleObservable.subscribe(onNext: { (value) in
            self.currencyToTF.text = "\(value.getTwoDigits)"
        }).disposed(by: disposeBag)
    }
    
    // Switch
    func switchCurrency(){
        self.viewModel.switchCurrency()
        var swipKey = ""
        var swipValue = ""
        swipKey = self.fromLable.text ?? ""
        self.fromLable.text  = self.toLable.text ?? ""
        self.toLable.text  = swipKey
        
        swipValue = self.currencyFromTF.text ?? ""
        self.currencyFromTF.text = self.currencyToTF.text ?? ""
        self.currencyToTF.text  = swipValue
    }
}


//MARK: - error 
extension ConvertCurrencyVC: ErrorProtocol{
    func featching(error: String) {
        self.showAlert(withTitle: false, msg: error, compilition: nil)
    }
}
