//
//  ControllerExtension.swift
//  Sosmed
//
//  Created by Paxel on 02/05/22.
//

import Foundation
import NVActivityIndicatorView

extension UIViewController: UIGestureRecognizerDelegate{
    
    func showLoadingView(_ message:String? = nil){
        startAnimating(CGSize(width: 40, height: 40), message: message, messageFont: UIFont.boldSystemFont(ofSize: 18), type: .ballPulse)
    }
    
    func showLoadingView(state:Bool,_ message: String? = nil){
        if state{
             startAnimating(CGSize(width: 40, height: 40), message: message, messageFont: UIFont.boldSystemFont(ofSize: 18), type: .ballPulse)
        }else{
            stopAnimating()
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func hideLoadingView() {
        stopAnimating()
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func showNavigationBar() {
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func hideNavigationBar() {
        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    static func topViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            if let nav = topController as? UINavigationController {
                return nav.topViewController
            }
            // topController should now be your topmost view controller
            return topController
        } else {
            return UIViewController()
        }
    }
    
}

extension UIViewController:NVActivityIndicatorViewable{
    
}
