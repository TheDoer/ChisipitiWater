//
//  TrackOrderDataViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 1/12/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit

class TrackOrderDataViewController: UIViewController {
    
    @IBOutlet weak var orderNumberLbl: UILabel!
    
    
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderDeliveryAddress: UILabel!
    @IBOutlet weak var orderStatusImg: UIImageView!
    @IBOutlet weak var orderStatusView: CustomView!
    
    @IBOutlet weak var orderStatusDispatched: UILabel!
    @IBOutlet weak var orderDateDispatched: UILabel!
    @IBOutlet weak var orderDeliveryAddressDispatched: UILabel!
    @IBOutlet weak var orderStatusImgDispatched: UIImageView!
    @IBOutlet weak var orderStatusViewDispatched: CustomView!
    
    
    @IBOutlet weak var orderStatusDelivered: UILabel!
    @IBOutlet weak var orderDateDelivered: UILabel!
    @IBOutlet weak var orderAddressDelivered: UILabel!
    @IBOutlet weak var orderStatusImgDelivered: UIImageView!
    @IBOutlet weak var orderStatusViewDelivered: CustomView!
    
    var trackOrder:TrackOrder!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // orderNumberLbl.text = trackOrder.orderId

        
    }
    

    

}
