//
//  ConfirmOrderDetailsViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 30/7/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability

class ConfirmOrderDetailsViewController: UIViewController {
    
    @IBOutlet weak var waterAmountLbl: UILabel!
    @IBOutlet weak var priceAmountLbl: UILabel!
    @IBOutlet weak var FullNameLbl: UILabel!
    @IBOutlet weak var MobileNumberLbl: UILabel!
    @IBOutlet weak var AddressLbl: UILabel!
    
    
    var UserInfo:UserLogin!
    
    var quantity:Int = 0
    var totalPriice:Int = 0
    
    var fullName:String = ""
    var mobileNumber:String = ""
    var address:String = ""
    
    var thousandZeros:String = "000"
    
    var reachability:Reachability?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
         print(" Totat Price Confirm = \(self.totalPriice)")
        
        priceAmountLbl.text = "Total Cost: USD\(self.totalPriice)"
        waterAmountLbl.text = "\(self.quantity) 000 Liters"
        FullNameLbl.text = "\(UserDetails.sharedInstance.name)"
        MobileNumberLbl.text = "\(UserDetails.sharedInstance.mobileno)"
        AddressLbl.text = "\(UserDetails.sharedInstance.physical_address)"
    }
    
    
    @IBAction func confirmOrder(_ sender: Any) {
        
        MakeOrder()
    }
    
    func ConfirmOrder(){
        
        performSegue(withIdentifier: "toConfimed", sender: self)
        
    }
   
    func MakeOrder(){
        
        do {
            self.reachability = try Reachability.init()
        } catch {
             print("Unable to start notifier")
        }
        
        if((reachability!.connection) != .unavailable){
            
             MBProgressHUD.showAdded(to: self.view, animated: true)
            
            
            let makeOrder_endpoint =     "http://tegloma.com/chisipiti_app/orders.php?mobileno=\(UserDetails.sharedInstance.mobileno)&units=\(self.quantity)\(self.thousandZeros)&confirm_order=1"
            
            print("EndPOINT: \(makeOrder_endpoint)")
            
            Alamofire.request(makeOrder_endpoint, method: .post).responseJSON { (response) in
                
                let result = response.result
                
                print("Post Response:\(response)")
                
                switch response.result {
                    
                case let .success(value):
                    
                    let OrderResponse = JSON(value)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    if OrderResponse["success"].boolValue == true {
                        
                        self.ConfirmOrder()
                            
                    }
                
                case let .failure(error):
                    print("NO")
                    print(error)
                    
                    let alert = UIAlertController(title: "", message: "Failed to place an order", preferredStyle: .alert)
                                
                                let closeAction = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.cancel, handler: {action in
                                    print("Close")
                                    
                                })
                     
                                alert.addAction(closeAction)
                                self.present(alert, animated: true, completion: nil)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    
                    
                    
                }
            }
        }
        
            
    }
    

    
     //MARK: - Navigation

     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toConfimed" {
            
            let destinationVC = segue.destination as! FinalOrderConfirmViewController
            
        }
         
    }
    

}
