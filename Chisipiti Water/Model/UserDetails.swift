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

 class UserDetails {
     
     private var _name: String!
     private var _mobile_number: String!
     private var _physical_address: String!
     private var _login_status: String!
     
     
    
     
     
     var mobile_number: String {
         if _mobile_number == nil {
             _mobile_number = ""
         }
         return _mobile_number
     }
     
     var physical_address: String {
         if _physical_address == nil {
             _physical_address = ""
         }
         
         return _physical_address
     }
     
     var name: String {
         if _name == nil {
             _name = ""
         }
         
         return _name
     }
    
    var login_status: String {
            if _login_status == nil {
                _login_status = ""
            }
            
            return _login_status
        }
     
     
     init(UserDetailsDict: JSON?) {
         self._mobile_number = UserDetailsDict!["mobileno"].stringValue
         self._name = UserDetailsDict!["name"].stringValue
         self._physical_address = UserDetailsDict!["physical_address"].stringValue
         self._login_status = UserDetailsDict!["login_status"].stringValue

     }
  
 }


