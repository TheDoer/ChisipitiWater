//
//  Extras.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 23/7/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit

extension String {
    
    var isNotEmpty: Bool {
        return !isEmpty
        
    }
}

extension LoginViewController {
    
    func simpleAlert(title: String, msg: String) {
               let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
   
}

extension SignUpViewController {
    
    func simpleAlert(title: String, msg: String) {
               let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }

}

extension OTPViewController {
    
    func simpleAlert(title: String, msg: String) {
               let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }

}


extension CustomerSupportViewController {
    
    func simpleAlert(title: String, msg: String) {
               let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }

}
