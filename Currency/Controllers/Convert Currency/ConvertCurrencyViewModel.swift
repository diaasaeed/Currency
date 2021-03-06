//
//  ConvertCurrencyViewModel.swift
//  Currency
//
//  Created by Diaa saeed on 4/12/22.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class ConvertCurrencyViewModel{
    
    //MARK: - variables

    // error
    private var error = PublishSubject<String>()
    var errorObservable : Observable<String>{
        return error
    }
    
    //  selected counrty
    private var Country = PublishSubject<String>()
    var CountryStringObservable : Observable<String>{
        return Country
    }
    
    // selected currency
    var fromCurrencyValue = 1.0
    var countryFromIndex = Int()
    var countryToIndex = Int()
    
    private var ToCurrency =  PublishSubject<Double>()
    var ToCurrencyDoubleObservable : Observable<Double>{
        return ToCurrency
    }
    
    // total Convert currency
    private var totalCurrency =  PublishSubject<Double>()
    var totalCurrencyDoubleObservable : Observable<Double>{
        return totalCurrency
    }
    
    // all currency
    private var CurrencyModelSubject = PublishSubject<[CountryCurrency]>()
    var CurrencyModelObservable : Observable<[CountryCurrency]>{
        return CurrencyModelSubject
    }
    var currenCycountry = [CountryCurrency]()

    // selected index from pickerView to get value of country
    var indexCurrencySelected = 0
    
    //Default Value
    private var DefaultCurrency =  PublishSubject<Double>()
    var DefaultCurrencyDoubleObservable : Observable<Double>{
        return DefaultCurrency
    }
    
    var myConvertCurrencyOBJ = MyConvertCurrencyOBJ()
    
    //MARK:- request get all currency
    func getCountry(){
        let url = "\( URls.shared.latest)?access_key=\(access_key)"
        APIClient.shared.getData(url: url,
                                 method: .get,
                                 params: nil,
                                 encoding: JSONEncoding.default,
                                 headers: nil) { (data:ConvertCurrencyModel?, statusCode, error:Error?) in
            
            if let error = error{
                print("Error",error.localizedDescription)
                
            }else  {
                guard let data = data else {   return  }
                if data.success == true{
                    // in status success
                    for (key, value) in data.rates ?? [String:Double]() {
                        let cuntryCurrencyOBJ = CountryCurrency()
                        cuntryCurrencyOBJ.country = key
                        cuntryCurrencyOBJ.currency = value
                        self.currenCycountry.append(cuntryCurrencyOBJ)
                    }
                    
                    self.CurrencyModelSubject.onNext(self.currenCycountry)
                    self.getDefaultCurrency()
                }else{
                    // in status false
                    print("Error apis is",data.error?.info ?? "")
                    self.error.onNext(data.error?.info ?? "")
                }
            }
        }
    }
    
    // get title country
    func getCountryTitle(){
        Country.onNext(self.currenCycountry[self.indexCurrencySelected].country ?? "")
    }
    

    //MARK: - calculations Currency
    func calculatorCurrency(){
        let currencyFrom = self.currenCycountry[countryFromIndex].currency ?? 0
        let currencyTo = self.currenCycountry[countryToIndex].currency ?? 0
        
        let total = (currencyTo/currencyFrom)*fromCurrencyValue
        self.totalCurrency.onNext(total)
        print("currencyFrom" , currencyFrom  , "currencyTo",currencyTo , "total",total.getTwoDigits)
        
        
        myConvertCurrencyOBJ.fromCountry = self.currenCycountry[countryFromIndex].country ?? ""
        myConvertCurrencyOBJ.toCounrty = self.currenCycountry[countryToIndex].country ?? ""
        myConvertCurrencyOBJ.fromCurrency = currencyFrom
        myConvertCurrencyOBJ.toCurrency = currencyTo
        myConvertCurrencyOBJ.amount = fromCurrencyValue
    }
    
    
    // Default value when open screen
    func getDefaultCurrency(){
        countryFromIndex = currenCycountry.firstIndex{ $0.country == "USD"} ?? 0
        countryToIndex = currenCycountry.firstIndex{ $0.country == "EGP"} ?? 0
        
        let currencyFrom = self.currenCycountry[countryFromIndex].currency ?? 0
        let currencyTo = self.currenCycountry[countryToIndex].currency ?? 0
        let total = (currencyTo/currencyFrom)*1
        self.DefaultCurrency.onNext(total)
        
        myConvertCurrencyOBJ.fromCountry = "USD"
        myConvertCurrencyOBJ.toCounrty = "EGP"
        myConvertCurrencyOBJ.fromCurrency = currencyFrom
        myConvertCurrencyOBJ.toCurrency = currencyTo
        myConvertCurrencyOBJ.amount = fromCurrencyValue

    }
    
    
    func switchCurrency(){
        var swip = 0 // to put the frist value
        swip = self.countryFromIndex
        self.countryFromIndex = countryToIndex
        self.countryToIndex = swip
        
    }
}
