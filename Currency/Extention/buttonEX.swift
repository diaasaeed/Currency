//
//  buttonEX.swift
//  Nazan
//
//  Created by apple on 6/21/20.
//  Copyright © 2020 Atiaf. All rights reserved.
//

import Foundation
import UIKit

 
extension UIButton{
    
    /// set the direction of the title label of the button
    func setDirection(){ }
    
    /// put under line in button string
    func underline() {
            guard let text = self.titleLabel?.text else { return }
            let attributedString = NSMutableAttributedString(string: text)
            //NSAttributedStringKey.foregroundColor : UIColor.blue
            attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
            self.setAttributedTitle(attributedString, for: .normal)
        }
    
    func unUnderLine(){
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        //NSAttributedStringKey.foregroundColor : UIColor.blue
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.titleColor(for: .normal)!, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
    
    /// set valid button style
    func valid(){
        self.setTitleColor( .black , for: .normal)
        self.backgroundColor = UIColor(named: "BaseColor")!
        self.isEnabled = true
    }
    
    
    /// set not valid button style
    func inValid(){
        self.setTitleColor( UIColor(named: "Invalid_Btn_ForeColor") , for: .normal)
        self.backgroundColor = UIColor(named: "Invaled_Btn_2")!
        self.isEnabled = false
    }
    
    func checked(){
        self.setImage(#imageLiteral(resourceName: "check-3"), for: .normal)
        self.backgroundColor = #colorLiteral(red: 1, green: 0.6588235294, blue: 0.07058823529, alpha: 1)
    }
    
    func unChecked(){
        self.setImage(nil, for: .normal)
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    }
    
   
    
    /// set static shadow for button
    func shadow(){
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.24)
        self.layer.shadowOpacity = 3.5
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
    }
    
    /// transform the button in X axis
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }
    
 
    
    /// set border style for buttom
    /// - Parameters:
    ///   - width: border with
    ///   - color: border color
    func setBorder(width: CGFloat, color: UIColor){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}


@IBDesignable extension UIButton {
    
    @IBInspectable var buttonRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColorButton: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get{
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable
    var borderWidthButton: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var shadowColorButton: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowOpacityButton: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffsetButton: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var shadowRadiusButton: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
}


@IBDesignable
class GradientButton: UIButton {
   
    @IBInspectable var startColor:  UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:   UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =  0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:  Double =  0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode: Bool = false { didSet { updatePoints() }}
  //  @IBInspectable var diagonalMode:  Bool = false { didSet { updatePoints() }}
    @IBInspectable var verticallMode: Bool = false { didSet { updatePoints() }}
     
    override public class var layerClass: AnyClass { return CAGradientLayer.self }
     
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
     
    func updatePoints() {
      if verticallMode{
          gradientLayer.startPoint = .init(x: 0, y: 0)
          gradientLayer.endPoint  = .init(x: 0, y: 1)
          
      }else{
          gradientLayer.startPoint = .init(x: 0, y: 0)
          gradientLayer.endPoint  = .init(x: 1, y: 0)
          
      }
 
    }
    
  func updateLocations() {
    gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
  }
  func updateColors() {
    gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
  }
  override public func layoutSubviews() {
    super.layoutSubviews()
    updatePoints()
    updateLocations()
    updateColors()
  }
}


class RectangularDashedButtonView: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
