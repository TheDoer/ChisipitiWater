//
//  OrderTrackingTableViewCell.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 26/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit

class OrderTrackingTableViewCell: UITableViewCell {

     //MARK: Outlets
       
       var orderStatus:Int? = nil
       
       @IBOutlet weak var backView: UIView!
       
    
       @IBOutlet weak var OrderStatusImage: UIImageView!
       @IBOutlet weak var OrderDateLbl: UILabel!
       @IBOutlet weak var AddressLbl: UILabel!
       @IBOutlet weak var OrderStatusLbl: UILabel!
       
       override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }
       
       func configureCell(orderTrack: TrackOrder){
          OrderDateLbl.text = "\(orderTrack.orderDate ?? "--.--.----")"
           AddressLbl.text = orderTrack.address
           //OrderAmountLbl.text = "\(history.orderVolume) L"
           
           self.orderStatus = orderTrack.orderStatus
           
           switch orderStatus  {
               
           case 0:
               OrderStatusLbl.text = "Order Accepted - \(orderTrack.orderVolume)Litres"
           case 1:
               OrderStatusLbl.text = "Order En-Route -\(orderTrack.orderVolume)Litres"
           case 2:
               OrderStatusLbl.text = "Order Delivered - \(orderTrack.orderVolume)Litres"
               
           case 3:
               OrderStatusLbl.text = "Order Cancelled - \(orderTrack.orderVolume)Litres"
               
           default:
               OrderStatusLbl.text = "Order Processing..."
               
           }
           
       }

}
