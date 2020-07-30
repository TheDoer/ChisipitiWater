//
//  Product.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 28/7/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product {
    
    private var _price:Int!
    
    var price: Int {
           if _price == nil {
               _price = 0
           }
           return _price
       }
    
    init(PriceDict: JSON?) {
        self._price = PriceDict!["price"].intValue
       }
}
