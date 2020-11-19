//
//  TrackOrder.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 6/8/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class TrackOrder {
    
    private var _orderId:String!
    private var _orderVolume:Int!
    private var _orderDate:String!
    private var _address:String!
    private var _orderStatus:Int!
    private var _fullName: String!
    
    
    var orderVolume: Int {
           if _orderVolume == nil {
               _orderVolume = 0
           }
        
           return _orderVolume
       }
    
    var address: String {
        
        if _address == nil {
            _address = ""
        }
        
        return _address
    }
    
    var orderDate: String! {
        if _orderDate == nil {
            _orderDate = ""
        }
        return _orderDate
    }
    
    var fullName:String! {
        if _fullName == nil {
            _fullName = ""
        }
        
        return _fullName
    }
    
    var orderId: String! {
        if _orderId == nil {
            _orderId = ""
        }
        
        return _orderId
    }
    
    var orderStatus: Int! {
        if _orderStatus == nil {
            _orderStatus = 0
        }
        
        return _orderStatus
        
    }
    
    init(tackOrderDict: JSON?) {
        self._fullName = tackOrderDict!["full_name"].stringValue
        self._orderVolume = tackOrderDict!["volume"].intValue
        self._address = tackOrderDict!["physical_address"].stringValue
        self._orderId = tackOrderDict!["order_id"].stringValue
        self._orderStatus = tackOrderDict!["order_status"].intValue
        self._orderDate = formattedDate(date: (tackOrderDict?["date_of_order"].stringValue)!)
        
      
        
  }
    
    func formattedDate(date: String) -> String {
           
           if date != "" {
               
               let index = date.index(date.startIndex, offsetBy: 15)
               let dateSubstring = date[..<index]
               
               let originalDate = dateSubstring.replacingOccurrences(of: "T", with: " ")
               
               let formatter = DateFormatter()
               formatter.locale = Locale(identifier: "en_US_POSIX")
               formatter.dateFormat = "yyyy-MM-dd HH:mm"
               
               if let Ddate = formatter.date(from: originalDate){
                   let displayFormatter = DateFormatter()
                   displayFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
                   
                   return displayFormatter.string(from: Ddate)
               }
           }
           
           return ""
           
           
       }
    
    
    
}

