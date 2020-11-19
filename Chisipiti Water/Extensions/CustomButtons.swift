//
//  CustomButtons.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 14/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit

class CustomButtton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusAndShadow()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRadiusAndShadow()
        
    }
    
    func setRadiusAndShadow(){
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
         
        
    }
}
