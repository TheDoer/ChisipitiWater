//
//  SignUpViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 12/7/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit
import Reachability
import Alamofire
import SwiftyJSON
import TextFieldEffects
import MBProgressHUD

class SignUpViewController: UIViewController {
    
      var reachability:Reachability?
    
    
    let backgroundImageView = UIImageView()
    let backgroundImageViewOne = UIImageView()
    
    @IBOutlet weak var FullNameTxt: HoshiTextField!
    @IBOutlet weak var PINTxt: HoshiTextField!
    @IBOutlet weak var AddressTxt: HoshiTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setBackgroundOne()
        setBackground()
    }
    
    @IBAction func createAccountBtn(_ sender: Any) {
        
        SignUpCallingAPI()
    }
    
    
    func SignUpCallingAPI(){
        
        do {
            self.reachability = try Reachability.init()
        }catch {
            print("Unable to start notifier")
        }
        
        if((reachability!.connection) != .unavailable){
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            let  mobileNumber = FullNameTxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            let  Pin = PINTxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            
          
            let login_endpoint = "http://tegloma.com/chisipiti_app/login.inc.php?mobileno=\(mobileNumber)&pin=\(Pin)"
            
             print(login_endpoint)
            
            Alamofire.request(login_endpoint,method: .get).responseString { (response) in
                
                print(" Response: \(response)")
            }
            
        }
        
       
        
    }
    
    func setBackground() {
          
          view.addSubview(backgroundImageView)
          backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
          backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
          backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
          backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
          backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
          backgroundImageView.image = UIImage(named: "Image_background")
          view.sendSubviewToBack(backgroundImageView)
          
      }
      
      func setBackgroundOne() {
          
          view.addSubview(backgroundImageViewOne)
          backgroundImageViewOne.translatesAutoresizingMaskIntoConstraints = false
          backgroundImageViewOne.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
          backgroundImageViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
          backgroundImageViewOne.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
          backgroundImageViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
          backgroundImageViewOne.image = UIImage(named: "Image-one")
          view.sendSubviewToBack(backgroundImageViewOne)
          
      }
    

    

}
