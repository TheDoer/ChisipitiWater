//
//  UserDetails.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 16/8/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserDetails {
    
    static let sharedInstance = UserDetails()
    
    var customerData = [String]()
    var name = ""
    var mobileno = ""
    var physical_address = ""
    var login_status = ""
    var signUp_Status = ""
}
