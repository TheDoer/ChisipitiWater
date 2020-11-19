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
    
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var MinusButton: UIButton!
    
    var reachability:Reachability?
    var price: Int = 0
    var quantity: Int = 1
    var totalPrice: Int = 0
    
    var fullName:String = ""
    var mobileNumber:String = ""
    var address:String = ""
    
    
    var ProductData = [Product]()
    
   
    @IBOutlet weak var waterQuantityLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlusButton.layer.cornerRadius = PlusButton.frame.width / 2
        PlusButton.layer.masksToBounds = true
        
        MinusButton.layer.cornerRadius = MinusButton.frame.width / 2
        MinusButton.layer.masksToBounds = true
        
        
        
        WaterPriceAPICalling()
    }
    
    @IBAction func plusBtn(_ sender: Any) {
        
        quantity = quantity + 1
        waterQuantityLbl.text = "\(quantity)"
        
        totalPrice = price * quantity
        
         priceLbl.text = "TOTAL PRICE: $\(totalPrice)"
    
        
    }
    
    @IBAction func minusBtn(_ sender: Any) {
        
        if quantity != 1 {
            quantity = quantity - 1
            waterQuantityLbl.text = "\(quantity)"
            
            totalPrice = price * quantity
            
            priceLbl.text = "TOTAL PRICE: $\(totalPrice)"
        }
        
    }
    
    
    @IBAction func placeOrderBtn(_ sender: Any) {
        
        
        MakeOrderCallingAPI()
    }
    

     func MakeOrderCallingAPI(){
        
           performSegue(withIdentifier: "toConfirmOrder", sender: self)
        
        print(" Qauntiity = \(self.quantity)")
        print(" Totat Price = \(self.totalPrice)")
        
 
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               
               if segue.identifier == "toConfirmOrder" {
                   
                   let destinationVC = segue.destination as! ConfirmOrderDetailsViewController
                   destinationVC.totalPriice = self.totalPrice
                   destinationVC.quantity = self.quantity
                   destinationVC.address = self.address
                   destinationVC.mobileNumber = self.mobileNumber
                   destinationVC.fullName = self.fullName
                
               }
           }

}
