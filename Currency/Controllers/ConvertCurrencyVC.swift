//
//  ViewController.swift
//  Currency
//
//  Created by Diaa saeed on 4/12/22.
//

import UIKit
import RxCocoa
import RxSwift


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
    var isSwip = false
    
    var keyFrom = String()
    var valueFrom = String()
    
    var keyTo = String()
    var valueTo = String()
    
    let disposeBag = DisposeBag()
    
    //MARK: - viewdidlaod
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapFrom = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom(_:)))
        viewFrom.addGestureRecognizer(tapFrom)
        
        let tapTo = UITapGestureRecognizer(target: self, action: #selector(self.handleTapTo(_:)))
        viewTo.addGestureRecognizer(tapTo)
    }

    //MARK: - actions
    @objc func handleTapFrom(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("From")
    }
 
    @objc func handleTapTo(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("To")
    }
    
    @IBAction func swipBTN(_ sender: Any) {
        
        
        
    }
    
    @IBAction func detailsBTN(_ sender: Any) {
        
    }
}

