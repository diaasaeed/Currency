//
//  imageViewEX.swift
//  Nazan
//
//  Created by apple on 6/21/20.
//  Copyright © 2020 Atiaf. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
//        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
 
extension UIImageView{
     
    /// transform the button in X axis
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }
    
    /// set side arrow depends on language
    func setSideArrow(){
        self.image = UIImage(named: "arrow")
    }
    
    /// set black side arrow depends on language
    func setBlackSideArrow(){
        self.image = UIImage(named: "blackArrow")
    }
}

 
@IBDesignable extension UIImageView {
    @IBInspectable var imgRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidthImage: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorImage: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get{
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowColorImage: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowOpacityImage: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffsetImage: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var shadowRadiusImage: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
}
