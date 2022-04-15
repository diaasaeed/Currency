//
//  HistoricalViewModel.swift
//  Currency
//
//  Created by Diaa saeed on 4/13/22.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

class HistoricalViewModel{
    //error
    private var error = PublishSubject<String>()
    var errorObservable : Observable<String>{
        return error
    }
    var popularCurrencies = ["EUR","JPY","GBP","AUD","CAD" , "USD","CHF","CNH","HKD","NZD","EGP"] // popular Currencies
    var ConvertCurrencyData = MyConvertCurrencyOBJ() // array of country code
    let myGroup = DispatchGroup()

    //all currency
    var popularCurrencycountry = [CountryCurrency]()
    private var otherCurrenciesModelSubject = PublishSubject<[String]>()
    var otherCurrenciesObservable : Observable<[String]>{
        return otherCurrenciesModelSubject
    }
    
    
    // last three days
    var lastCurrencyArr = [String]()
    var LastCurrencycountry = [CountryCurrency]()
    private var LastCurrencyModelSubject = PublishSubject<[String]>()
    var LastCurrencyObservable : Observable<[String]>{
        return LastCurrencyModelSubject
    }

    // Chart Date
    var indexDay = 1 // use it to chart
    var dateChart = [Double]()
    private var ChartDateModelSubject = PublishSubject<[Double]>() // use it to chart
    var ChartDateObservable : Observable<[Double]>{ // use it to chart
        return ChartDateModelSubject
    }
    
    // Chart Value
    var valueChart = [Double]()
    private var ChartvalueModelSubject = PublishSubject<[Double]>() // use it to chart
    var ChartvalueObservable : Observable<[Double]>{ // use it to chart
        return ChartvalueModelSubject
    }
    
    //MARK: - when load
    func viweDidload(){
        GetlastThreeDays()
        getAllCountry()
        
        myGroup.notify(queue: DispatchQueue.main, execute: {
            self.LastCurrencyModelSubject.onNext(self.lastCurrencyArr)
        })
    }
    
    //MARK:- get last three  Date
    func getCurrentDate(num:Int)->String{
        guard let date = Calendar.current.date(byAdding: .day, value: -(num), to: Date()) else {   return ""   }
        let CurrentData = date.toString(withFormat: "YYYY-MM-dd")
        return CurrentData
    }
    
    func GetlastThreeDays(){
        for i in 1..<4{
            let historicalDate = getCurrentDate(num: i)
            print("HistoricalDate is \(i)"  ,historicalDate)
            self.getHistorical(Date: historicalDate)
        }
    }
    
    //MARK: - get currency With date
    func getHistorical(Date:String){
        myGroup.enter()
        var url = URls.shared.Domain
        url+="\(Date)?access_key=\(access_key)"
        url+="&symbols=\("\(ConvertCurrencyData.fromCountry ?? ""),\(ConvertCurrencyData.toCounrty ?? "")")"
        url+="&format=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        APIClient.shared.getData(url: url,
                                 method: .get,
                                 params: nil,
                                 encoding: JSONEncoding.default,
                                 headers: nil) { (data:ConvertCurrencyModel?, statusCode, error:Error?) in
            self.LastCurrencycountry.removeAll()
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
                        self.LastCurrencycountry.append(cuntryCurrencyOBJ)
                    }
                    self.getResultLastThreeDays()
                   
                }else{
                    // in status false
                    self.error.onNext(data.error?.info ?? "")
                }
            }
            self.myGroup.leave()
        }
    }
    
    // get final resulat and chart data
    func getResultLastThreeDays(){
        let countryFromIndex = self.LastCurrencycountry.firstIndex{ $0.country == self.ConvertCurrencyData.fromCountry ?? ""} ?? 0
        let currencyFrom = self.LastCurrencycountry[countryFromIndex].currency ?? 0.0
        let countryToIndex = self.LastCurrencycountry.firstIndex{ $0.country == self.ConvertCurrencyData.toCounrty ?? ""} ?? 0
        let currencyTo = self.LastCurrencycountry[countryToIndex].currency ?? 0.0
        let countryTitleTo = self.LastCurrencycountry[countryToIndex].country ?? ""
        let result = ((currencyTo/currencyFrom))*(ConvertCurrencyData.amount ?? 0)
        let resultCurrency =  "\(result.getTwoDigits) \(countryTitleTo)"
        
        //chart
        let date = Calendar.current.date(byAdding: .day, value: -(self.indexDay), to: Date())
        self.indexDay+=1 // to get perivuos Day
        let CurrentData = date?.toString(withFormat: "YYYY MMM dd") ?? ""
        let day = date?.get(.day) ?? 0
        let month = date?.get(.month) ?? 0
        let dayMonth = Double("\(day).\(month)") ?? 0
//        print("Date chart is", dayMonth)

        self.dateChart.insert(dayMonth, at: 0) //apped chart Date in array because it get from 3 call api
        self.ChartDateModelSubject.onNext(self.dateChart)//chart Date
        self.valueChart.append(result) //apped chart value in array because it get from 3 call api
        self.ChartvalueModelSubject.onNext(valueChart)//chart value
        
        
        // thre day
        let resultWithDate = "\(CurrentData)\n\(resultCurrency)"
        lastCurrencyArr.append(resultWithDate)
        self.LastCurrencyModelSubject.onNext(lastCurrencyArr)

    }
 
    //MARK: - get Other Currencies
    
    func getAllCountry(){
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
                        self.popularCurrencycountry.append(cuntryCurrencyOBJ)
                    }
                    self.popularCurrenciesFilter()
                }else{
                    // in status false
                    self.error.onNext(data.error?.info ?? "")
                }
            }
        }
    }
    
    func popularCurrenciesFilter(){
        let countryBaseIndex = popularCurrencycountry.firstIndex{ $0.country == self.ConvertCurrencyData.fromCountry ?? ""} ?? 0
        let currencyBase = popularCurrencycountry[countryBaseIndex].currency ?? 0.0
        var Currencies = [String]()

        for i in popularCurrencies{
            let countryIndex = popularCurrencycountry.firstIndex{ $0.country == i} ?? 0
            let currecny = popularCurrencycountry[countryIndex].currency ?? 0
            let totalResualt = (currecny)/(currencyBase)*(ConvertCurrencyData.amount ?? 0)
            let resultCurrency = "\(totalResualt.getTwoDigits) \(i)"
            Currencies.append(resultCurrency)
            self.otherCurrenciesModelSubject.onNext(Currencies)
        }
    }
     
}

