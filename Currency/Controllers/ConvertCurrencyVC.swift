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

class ConvertCurrencyVC: UIViewController {
    
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

        InterNet.shared.checkInternet { (networkCheck) in
            if networkCheck{
                self.callAllFunctions()
            }else{
                self.showAlert(withTitle: false, msg: "No internet connections", compilition: nil)
            }
        }
     }
    
 
    //MARK: - actions
    @objc func handleTapFrom(_ sender: UITapGestureRecognizer? = nil) {
        print("From")
        currencyType = .from
        pickerViewTap()
        view.endEditing(true)
        pickerView.reloadAllComponents()
        
    }
    
    @objc func handleTapTo(_ sender: UITapGestureRecognizer? = nil) {
        print("To")
        currencyType = .to
        pickerViewTap()
        view.endEditing(true)
        pickerView.reloadAllComponents()
    }
    
    @objc func fromTFAction(_ textField: UITextField) {
        self.currencyToTF.text = ""
    }
    
    
    @IBAction func switchBTN(_ sender: Any) {
        switchCurrency()
    }
    
    @IBAction func detailsBTN(_ sender: Any) {
        self.viewModel.fromCurrencyValue = Double(self.currencyFromTF.text ?? "") ?? 0.0
        self.viewModel.calculatorCurrency()
        view.endEditing(true)
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
