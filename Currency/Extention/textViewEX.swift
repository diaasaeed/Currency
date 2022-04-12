//
//  textViewEX.swift
//  AlShaden
//
//  Created by apple on 7/8/20.
//  Copyright © 2020 Atiaf. All rights reserved.
//

import UIKit

extension UITextView{
    
    /// convert html String to styled text
    /// - Parameter text: the htmlText
    func setHTMLFromString(text: String) {
      let modifiedFont = NSString(format:"<span style=\"font-family: \(self.font!.fontName); font-size: \(14)\">%@</span>" as NSString, text)
      let attrStr = try! NSAttributedString(
        data: modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)!,
        options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
        documentAttributes: nil)
      self.attributedText = attrStr
    }
    
    /// set direction of text in label
    func setDirection(){
        if app_lang == "ar"{
            self.textAlignment = .right
        }else{
            self.textAlignment = .left
        }
    }
}



extension UITextField{
    
    /// set direction of text in label
    func setDirection(){
        if app_lang == "ar"{
            self.textAlignment = .right
        }else{
            self.textAlignment = .left
        }
    }
    
    /// set place holder with custome color
    /// - Parameter color: teh color that you want to set to placeholder
    func setPlaceHolder(color: UIColor){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                     attributes: [NSAttributedString.Key.foregroundColor: color,
                                                  NSAttributedString.Key.font: UIFont(name: "BahijTheSansArabic-SemiBold", size: 14)!])
    }
}
