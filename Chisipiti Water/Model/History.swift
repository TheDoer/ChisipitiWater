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
    
    private var _volume:Int!
    private var _orderDate:String!
    private var _address:String!
    
    
    var volume: Int {
           if _volume == nil {
               _volume = 0
           }
        
           return _volume
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
    
    init(HistoryDict: JSON?) {
        self._volume = HistoryDict!["volume"].intValue
        self._address = HistoryDict!["physical_address"].stringValue
        
         // Initialize Date string
        let dateStr = HistoryDict!["date_of_order"].stringValue

         // Set date format
        let dateFmt = DateFormatter()
        dateFmt.timeZone = NSTimeZone.default
        dateFmt.dateFormat =  "yyyy-MM-dd HH:mm:ss"
        

         // Get NSDate for the given string
        let date = dateFmt.date(from: dateStr)
        
        self._orderDate = "\(date)"
        
        
  }
    
}
