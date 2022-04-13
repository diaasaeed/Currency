//
//  viewControllerEX.swift
//  Khan Market
//
//  Created by apple on 7/22/20.
//  Copyright © 2020 Atiaf. All rights reserved.
//

import UIKit

extension UIAlertAction {
    
    /// get alert title color variable
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}


/// alert protocol to control types of alerts
protocol Alertable: AnyObject{
    /// show ALert to ask user to login first or cancle
    func loginAlert(compilition: (() -> Void)?)
    
    /// show ALert for confirmation on logout of the application
    /// - Parameter compilition: the closuer that excute when the user clicks on ok button
    func logoutAlert(compilition: @escaping () -> Void)
    
    /// show ALert style for validation Error
    /// - Parameters:
    ///   - error: the type of error to get the alert Message
    ///   - compilition: the closuer that excute after periodic time 2 sec
    func showErrorAlert(error: errors, compilition: (() -> Void)?)
    
    /// show ALert style for API Error
    /// - Parameter error: the type of error to get the alert Message
    func showAPIErrorAlert(error: APIErrors)
    
    /// show ALert style with custom message
    /// - Parameters:
    ///   - withTitle: detect the 'alert' message that it is shown or not
    ///   - msg: the error description message that will show under
    ///   - compilition: the closuer that excute after periodic time 2 sec
    func showAlert(withTitle: Bool, msg: String, compilition: (() -> Void)?)
    
    /// show ALert style with custom message includes action to dismiss it
    /// - Parameter msg: the error description message that will show under
    func showActionAlert(msg: String)
    
//    /// handle the API Error depends onstatus code
//    /// - Parameter code: the status code from API
//    func errorHandling(code: Int)
    
    /// show ALert style for confirmation message
    /// - Parameters:
    ///   - msg: the confirmation message
    ///   - compilition: the closuer that excute when the user clicks on ok button
    func showConfirmActionsAlert(msg: String, compilition: @escaping () -> Void)
    
    /// show activity ViewController to detect the action of the user on the file that downloaded from API
    /// - Parameter fileUrl: the response file URL
    func saveDownloadedFile(fileUrl: URL?)
}






extension UIViewController{
     /// create gester to the view to end editing
 
    /// conform the Internet class
    func interet(){
     
       
    }
    
    
    //MARK: - alert
    
//    /// handle the API Error depends onstatus code
//    /// - Parameter code: the status code from API
//    func errorHandling(code: Int){
//        if (code >= 500){
//            showAPIErrorAlert(error: .ServerError)
//
//        }else if (code >= 400 && code < 500){
//            showAPIErrorAlert(error: .Badrequest)
//
//        }else{
//            showAPIErrorAlert(error: .UnKnownError(<#T##errorStr: String##String#>))
//        }
//    }
    
    /// show ALert style for API Error
    /// - Parameter error: the type of error to get the alert Message
    func showAPIErrorAlert(error: APIErrors){
        let alert = UIAlertController(title: "Alert".localized, message: error.localizedErrorDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    /// show ALert style for validation Error
    /// - Parameters:
    ///   - error: the type of error to get the alert Message
    ///   - compilition: the closuer that excute after periodic time 2 sec
    func showErrorAlert(error: errors, compilition: (() -> Void)?){
        let alert = UIAlertController(title: "Alert".localized, message: error.rawValue.localized, preferredStyle: .alert)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (_) in
            alert.dismiss(animated: true){
                compilition?()
            }
        }
        
        present(alert, animated: true)
    }
    
    /// show ALert style with custom message
    /// - Parameters:
    ///   - withTitle: detect the 'alert' message that it is shown or not
    ///   - msg: the error description message that will show under
    ///   - compilition: the closuer that excute after periodic time 2 sec
    func showAlert(withTitle: Bool, msg: String, compilition: (() -> Void)?){
        let alert = UIAlertController(title: withTitle ? "Alert".localized : "", message: msg, preferredStyle: .alert)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (_) in
            alert.dismiss(animated: true){
                compilition?()
            }
        }
        present(alert, animated: true)
        
    }
    
    /// show ALert style with custom message includes action to dismiss it
    /// - Parameter msg: the error description message that will show under
    func showActionAlert(msg: String){
        let alert = UIAlertController(title: "Alert".localized, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
        
    }
    
    /// show ALert style for confirmation message
    /// - Parameters:
    ///   - msg: the confirmation message
    ///   - compilition: the closuer that excute when the user clicks on ok button
    func showConfirmActionsAlert(msg: String, compilition: @escaping () -> Void){
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".localized, style: .destructive){ (_) in
            compilition()
        }
        
        let cancle = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancle)
        present(alert, animated: true)
    }
    
    
    /// show ALert style for confirmation message with title
    /// - Parameters:
    ///   - msg: the confirmation message
    ///   - compilition: the closuer that excute when the user clicks on ok button
    func showAlertWithTitle(title:String,msg: String, compilition: @escaping () -> Void){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".localized, style: .default){ (_) in
            compilition()
        }
         alert.addAction(ok)
         present(alert, animated: true)
    }
    
    /// show activity ViewController to detect the action of the user on the file that downloaded from API
    /// - Parameter fileUrl: the response file URL
    func saveDownloadedFile(fileUrl: URL?){
        if let fileUrl = fileUrl{
            let activityViewController = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
   
    /// show ALert for confirmation on logout of the application
    /// - Parameter compilition: the closuer that excute when the user clicks on ok button
    func logoutAlert(compilition: @escaping () -> Void){
        let alert = UIAlertController(title: "Alert".localized, message: "logoutAlert".localized, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".localized, style: .destructive){ (_) in
            compilition()
        }
        
        let Cancel = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(Cancel)
        present(alert, animated: true)
    }
    
    
    /// open action Sheet to choose source of selection photo
    /// - Parameters:
    ///   - imagePicker: image picker controller
    ///   - Scope: scope compilition
    func chooseImgActionSheet(imagePicker: UIImagePickerController, Scope: (() -> ())){
        Scope()
        let alert = UIAlertController(title: "Choose photo".localized, message: "", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera".localized, style: .destructive) { (action) in
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let gallary = UIAlertAction(title: "Gallery".localized, style: .destructive) { (action) in
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        let cancle = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        if let popoverPresentationController = alert.popoverPresentationController {
            
            popoverPresentationController.sourceRect = self.view.frame
            popoverPresentationController.sourceView = self.view
            
        }
        alert.addAction(camera)
        alert.addAction(gallary)
        alert.addAction(cancle)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
