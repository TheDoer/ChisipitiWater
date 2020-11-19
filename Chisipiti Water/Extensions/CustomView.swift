//
//  CustomView.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 14/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit


class CustomView: UIView {

override init(frame: CGRect) {
    super.init(frame: frame)
    setRadiusAndShadow()
    
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setRadiusAndShadow()
    
}

func setRadiusAndShadow(){
    layer.cornerRadius = 5
    clipsToBounds = true
    layer.masksToBounds = false
    layer.shadowRadius = 5
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: 3, height: 0)
    layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
     
    }

}

    
