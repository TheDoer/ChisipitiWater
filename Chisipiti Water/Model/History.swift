//
//  History.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 4/8/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class History {
    
    private var _orderNumber:String!
    private var _orderVolume:Int!
    private var _orderDate:String!
    private var _address:String!
    private var _orderStatus:Int!
    
    
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
    
    var orderStatus: Int! {
        if _orderStatus == nil {
            _orderStatus = 0
        }
        
        return _orderStatus
        
    }
    
    init(HistoryDict: JSON?) {
        self._orderStatus = HistoryDict!["status_delivery"].intValue
        self._orderVolume = HistoryDict!["volume"].intValue
        self._orderDate = formattedDate(date: (HistoryDict?["date_of_order"].stringValue)!)
        self._address = HistoryDict!["physical_address"].stringValue
        
        
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
