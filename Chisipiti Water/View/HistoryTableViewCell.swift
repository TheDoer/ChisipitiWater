//
//  HistoryTableViewCell.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 27/10/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    var orderStatus:Int? = nil
    
    @IBOutlet weak var backView: UIView!
    
 
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
    
    func configureCell(history: History){
       OrderDateLbl.text = "\(history.orderDate ?? "--.--.----")"
        AddressLbl.text = history.address
        //OrderAmountLbl.text = "\(history.orderVolume) L"
        
        self.orderStatus = history.orderStatus
        
        switch orderStatus  {
            
        case 0:
            OrderStatusLbl.text = "Order Accepted - \(history.orderVolume)Litres"
        case 1:
            OrderStatusLbl.text = "Order En-Route -\(history.orderVolume)Litres"
        case 2:
            OrderStatusLbl.text = "Order Delivered - \(history.orderVolume)Litres"
            
        case 3:
            OrderStatusLbl.text = "Order Cancelled - \(history.orderVolume)Litres"
            
        default:
            OrderStatusLbl.text = "Order Processing..."
            
        }
        
    }
    
}
