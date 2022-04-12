//
//  viewEX.swift
//  Nazan
//
//  Created by apple on 6/21/20.
//  Copyright © 2020 Atiaf. All rights reserved.
//

import UIKit
extension UIView{
    
//    func active(){
//        self.layer.borderColor = Colors.DarkGreen.cgColor
//    }
//    
//    func initialForm(){
//        self.layer.borderColor = Colors.TFBorder.cgColor
//    }
//    
//    func Error(){
//        self.layer.borderColor = Colors.Error.cgColor
//    }
    
    /// rotate the view
    /// - Parameter angle: the angle that you wnts to rotate with
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    
    
    
//    func static_shadow(withOffset value:CGSize,color: CGColor){
//        self.layer.shadowColor = color
//        self.layer.shadowOpacity = 3.5
//        self.layer.shadowOffset = value
//        self.layer.shadowRadius = 3.5
//
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
//        self.clipsToBounds = false
//        self.layer.masksToBounds = false
//    }
    /// set static shadow for view depends on color and offset
    /// - Parameters:
    ///   - value: the offset of the shadow
    ///   - color: the color of the shadow
    func static_shadow(withOffset value:CGSize, color: UIColor) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 3.5
        layer.shadowOffset = value
        layer.shadowRadius = 14

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
      }
    
    
    /// set static shadow for cell view depends on color and offset
    /// - Parameter color: the color of the shadow
//    func cell_shadow(color: UIColor? = nil){
//        self.layer.shadowColor = color != nil ? color?.cgColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2954475309)
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: 0, height:0)
//        self.layer.shadowRadius = 3
//        self.clipsToBounds = false
//        self.layer.masksToBounds = false
//    }
    
    /// set static shadow for cell view depends on color and offset
    /// - Parameter color: the color of the shadow
    func cell_shadow(color: UIColor? = nil) {
        layer.masksToBounds = false
        layer.shadowColor = color != nil ? color?.cgColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2954475309)
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height:0)
        layer.shadowRadius = 3

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
      }
    
    /// set shadow of the view
    /// - Parameter color: color of the shadow and its optional
    func shadow(offset: CGSize? = nil,color: UIColor? = nil){
        self.layer.shadowColor = color != nil ? color?.cgColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2954475309)
        self.layer.shadowOpacity = 3.5
        self.layer.shadowOffset = offset ?? CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6
        self.layer.masksToBounds = false
    }
    
    
    /// set corner radius for specific corners and detect the language for mirring the View
    /// - Parameters:
    ///   - topLeft: topLeft
    ///   - topRight: topRight
    ///   - bottomLeft: bottomLeft
    ///   - bottomRight: bottomRight
    func setCurveToCorners(topLeft: Bool? = nil, topRight: Bool? = nil, bottomLeft: Bool? = nil, bottomRight: Bool? = nil) -> [CACornerMask]{
    
//        self.layer.maskedCorners =
        
        var corners = [CACornerMask]()
        
        if topLeft ?? false{
            corners.append(app_lang == "en" ? .layerMinXMinYCorner : .layerMinXMaxYCorner)
        }
        
        if topRight ?? false{
            corners.append(app_lang == "en" ? .layerMinXMaxYCorner : .layerMinXMinYCorner)
        }
        
        if bottomLeft ?? false{
            corners.append(app_lang == "en" ? .layerMaxXMinYCorner : .layerMaxXMaxYCorner)
        }
        
        if bottomRight ?? false{
            corners.append(app_lang == "en" ? .layerMaxXMaxYCorner : .layerMinXMaxYCorner)
        }
        
        return corners
    }
    
}

// extension for shadow
@IBDesignable extension UIView {
    @IBInspectable var viewRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidthView: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var shadowColorView: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.shadowColor = uiColor.cgColor
        }
        get{
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var borderColorView: UIColor?{
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get{
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var shadowOpacityView: Float{
        set {
            layer.shadowOpacity = newValue
        }
        get{
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffsetView: CGSize{
        set {
            layer.shadowOffset = newValue
        }
        get{
            return layer.shadowOffset
        }
    }
    
    @IBInspectable var shadowRadiusView: CGFloat{
        set {
            layer.shadowRadius = newValue
        }
        get{
            return layer.shadowRadius
        }
    }
    
}



enum direction{
    case vertical
    case horizontal
    case diagonal
        
}

/// gradiand color for the View
@IBDesignable
class GradientView: UIView {
   
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
    
//    if horizontalMode {
//      gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0, y: 0)
//      gradientLayer.endPoint  = diagonalMode ? .init(x: 1, y: 1) : .init(x: 1, y: 0)
//    } else {
//      gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0, y: 0)
//      gradientLayer.endPoint  = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0)
//    }
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


class RectangularDashedView: UIView {
    
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
