//
//  UIViewController+Extension.swift
//  Favourite Movies
//
//  Created by Ashrith Jain on 09/07/22.
//

import Foundation
import UIKit

extension UIViewController{
    
    func setNavigationTitle(title:String) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationItem.title = title
    }
    
    func setNavigationBackButtonTitle(title:String){
        let backButton = UIBarButtonItem()
        backButton.title = title
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func showActivityIndicator(show:Bool){
        if !show{
            hideActivityIndicator()
            return
        }
        
        DispatchQueue.main.async {
            let window:UIWindow? = self.view.window
            guard let unwrapedWindow = window else { return }
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            unwrapedWindow.addSubview(activityIndicator)
            activityIndicator.centerYAnchor.constraint(equalTo: unwrapedWindow.centerYAnchor).isActive = true
            activityIndicator.centerXAnchor.constraint(equalTo: unwrapedWindow.centerXAnchor).isActive = true
            activityIndicator.startAnimating()
        }

        
        
    }
    
    func hideActivityIndicator(){
        DispatchQueue.main.async {
            let window:UIWindow? = self.view.window
            guard let unwrapedWindow = window else { return }
            for view in unwrapedWindow.subviews{
                if view is UIActivityIndicatorView{
                    view.removeFromSuperview()
                }
            }
        }

    }
}
