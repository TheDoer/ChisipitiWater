//
//  RoundedButtons.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 12/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedButtons: UIButton {
   
    @IBInspectable var RoundedButtons: Bool = false {
        didSet {
            if RoundedButtons {
                layer.cornerRadius = frame.height/2
            }
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        if RoundedButtons {
            layer.cornerRadius = frame.height/2
        }
    }
}
