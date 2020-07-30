//
//  OrderViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 23/7/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit
import Reachability
import Alamofire
import SwiftyJSON
import TextFieldEffects
import MBProgressHUD

class OrderViewController: UIViewController {
    
    var reachability:Reachability?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    func OrderHistoryCallingAPI(){
        
        do {
            self.reachability = try Reachability.init()
        }catch {
            print("Unable to start notifier")
        }
        
        if((reachability!.connection) != .unavailable){
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
          
            let order_endpoint = "http://tegloma.com/chisipiti_app/registration.php?mobileno=263775462869&otp=5073"
        }
        
    }
  

}
