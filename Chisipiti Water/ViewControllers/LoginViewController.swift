//
//  LoginViewController.swift
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

class LoginViewController: UIViewController {
    
    
    
    var reachability:Reachability?
    
    var userDetails = [UserDetails]()
    var loginStatus = ""
    
    
    let backgroundImageView = UIImageView()
    let backgroundImageViewOne = UIImageView()
    
    @IBOutlet weak var phoneNumberTxt: HoshiTextField!
    @IBOutlet weak var PINTxt: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setBackgroundOne()
        setBackground()
        
        
    }
    
    @IBAction func LoginBtn(_ sender: Any) {
        
        
        guard let name = phoneNumberTxt!.text, name.isNotEmpty,
                   let password = PINTxt!.text, password.isNotEmpty else {
                       simpleAlert(title: "Error", msg: "Please fill all login fields")
                        return
               }
        
        
        LogInCallingAPI()
    
    }
    
    
    
    @IBAction func ResetPinBtn(_ sender: Any) {
        
        
    }
    

    func LogInCallingAPI(){
        
        do {
            self.reachability = try Reachability.init()
        }catch {
            print("Unable to start notifier")
        }
        
        if((reachability!.connection) != .unavailable){
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            let  mobileNumber = phoneNumberTxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            let  Pin = PINTxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            
          
            let login_endpoint = "http://tegloma.com/chisipiti_app/registration.php?mobileno=\(mobileNumber)&pin=\(Pin)"
            
           // http://tegloma.com/chisipiti_app/registration.php?mobileno=263774731945&pin=123
            
             print(login_endpoint)
            
            Alamofire.request(login_endpoint,method: .get).responseJSON { (UserDetailsResponse) in
                
                //print(" Response: \(UserDetailsResponse.result)")
                
                switch UserDetailsResponse.result {
                    
                case .success:
                    let userData = try? JSON(data: UserDetailsResponse.data!)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    let userDataArray = userData![]
                    
                    for i in 0..<userDataArray.count {
                        
                        let UserDetailsItems = UserDetails(UserDetailsDict: userDataArray[i])
                        self.userDetails.append(UserDetailsItems)
                        
                        print("UserDatails: \(UserDetailsItems.mobile_number)")
                        
                        self.loginStatus = UserDetailsItems.login_status
                        
                        print("Login Status: \(self.loginStatus )")
                    
                        
                        if self.loginStatus == "success" {
                            
                            self.performSegue(withIdentifier: "toMakeOrderView", sender: self)
                            
                        
                        }
                        
                        
                        
                      
                    }
                    
                   
                case .failure:
                    break
                    
                }
                
                
                
            }
            
            
        }
        
         MBProgressHUD.hide(for: self.view, animated: true)
        
       
        
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
