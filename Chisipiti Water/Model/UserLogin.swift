//
//  UserDetails.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 28/7/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

 import Foundation
 import Alamofire
 import SwiftyJSON

 class UserLogin {
    
    private var _login_status: String!
    private var _mobileno: String!
    private var _physical_address: String!
    private var _name: String!
    

    var login_status: String {
            if _login_status == nil {
                _login_status = ""
            }
            
            return _login_status
        }
    
    var mobileno: String {
        if _mobileno == nil {
            _mobileno = ""
        }
        
        return _mobileno
        
    }
    
    var physical_address: String! {
        if _physical_address == nil {
            _physical_address = ""
        }
        
        return _physical_address
    }
    
    var name: String! {
        if _name == nil {
            _name = ""
        }
        
        return _name
    }
    
    
    init(UserDict: JSON?) {
        self._login_status = UserDict!["login_status"].stringValue
        self._mobileno = UserDict!["mobileno"].stringValue
        self._physical_address = UserDict!["physical_address"].stringValue
        self._name = UserDict!["name"].stringValue
        

           }
    
       
     
    
  
 }


