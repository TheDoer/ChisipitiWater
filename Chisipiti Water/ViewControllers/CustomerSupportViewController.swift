//
//  CustomerSupportViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 19/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit
import TextFieldEffects
import Alamofire
import SwiftyJSON
import Reachability

class CustomerSupportViewController: UIViewController {
    
    
    @IBOutlet weak var queryMsgText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    

   
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendQueryBtn(_ sender: Any) {
        
         SendQuery()
        
    }
    
    func SendQuery(){
        
    }
    
}
