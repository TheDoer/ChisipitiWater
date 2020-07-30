//
//  SettingOrderViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 16/7/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit
import Reachability
import Alamofire
import SwiftyJSON
import TextFieldEffects
import MBProgressHUD

class MakeOrderViewController: UIViewController {
    
    var reachability:Reachability?
    var price: Int = 0
    var quantity: Int = 1
    var totalPrice: Int = 0
    
    var ProductData = [Product]()
    
   
    @IBOutlet weak var waterQuantityLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        WaterPriceAPICalling()
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        
        quantity = quantity + 1
        waterQuantityLbl.text = "\(quantity)"
        
        totalPrice = price * quantity
        
        priceLbl.text = "\(totalPrice)"
    
        
    }
    
    @IBAction func minusBtn(_ sender: Any) {
        
        if quantity != 1 {
            quantity = quantity - 1
            waterQuantityLbl.text = "\(quantity)"
            
            totalPrice = price * quantity
            
            priceLbl.text = "\(totalPrice)"
        }
        
    }
    
    
    @IBAction func placeOrderBtn(_ sender: Any) {
        
        MakeOrderCallingAPI()
        
    }
    

     func MakeOrderCallingAPI(){
        
        // PerfomaSegue to Confirm Details
    
          
          do {
              self.reachability = try Reachability.init()
          }catch {
              print("Unable to start notifier")
          }
          
          if((reachability!.connection) != .unavailable){
              
              MBProgressHUD.showAdded(to: self.view, animated: true)
            
              let makeOrder_endpoint = "http://tegloma.com/chisipiti_app/orders.php?mobileno=263774731945&units=7000&confirm_order=1"
          }
          
      }
    
    
    
    func WaterPriceAPICalling(){
        
        do {
            self.reachability = try Reachability.init()
        }catch {
            print("Unable to start notifier")
        }
        
        if((reachability!.connection) != .unavailable){
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
          
            let price_endpoint = "http://tegloma.com/chisipiti_app/price.php"
            
            Alamofire.request(price_endpoint, method: .get).responseJSON { (priceResponse) in
                //print(" Response: \(priceResponse.value)")
                
                switch priceResponse.result {
                    
                case .success:
                    let PriceData = try? JSON(data: priceResponse.data!)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    let price = PriceData![]
                    
                    for i in 0..<price.count {
                        
                        let priceItem = Product(PriceDict: price[i])
                        self.ProductData.append(priceItem)
                        
                        print("PriceItem: \(priceItem.price)")
                        
                        self.price = priceItem.price
                       
                    }
                    
                    case .failure:
                    break
                }
            }
        }
        
        
    }

}
