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
    
    var userLogin = [UserLogin]()
    

    var reachability:Reachability?
    
    var loginMessage = ""
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
                       simpleAlert(title: "Oops!", msg: "Please fill all login fields")
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
            
            
            Alamofire.request(login_endpoint,method: .get, encoding:JSONEncoding.default).responseJSON {
                (response) in
                
                 let result = response.result
                
                
                switch response.result {
                    
                case let .success(value):
                  
                    
                    let userData = JSON(value)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    if userData["success"].boolValue == true {
                        
                        let LoginJSONData = JSON(result.value!)["data"]
                        print("LoginJSONData1: \(LoginJSONData)")
                        
                        for i in 0..<LoginJSONData.count {
                            
                            let userData = UserLogin(UserDict: LoginJSONData[i])
                            self.userLogin.append(userData)
                        }
                        
                        UserDetails.sharedInstance.name = JSON(result.value!)["data"][0]["name"].stringValue
                        UserDetails.sharedInstance.mobileno = JSON(result.value!)["data"][0]["mobileno"].stringValue
                        UserDetails.sharedInstance.physical_address = JSON(result.value!)["data"][0]["physical_address"].stringValue
                        UserDetails.sharedInstance.login_status = JSON(result.value!)["data"][0]["login_status"].stringValue
                        
                         print("userData: \(userData)")
                        self.performSegue(withIdentifier: "toMakeOrderView", sender: self)
                        
                    
                    }
                        
                    else  {
                    
                    let alert = UIAlertController(title: "Oops!", message: "Either your mobile number or passwoord is incorrect", preferredStyle: .alert)
                                           
                     let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: {action in
                                            
                                               
                        })
                            alert.addAction(closeAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    
                   
                case let .failure(error):
                
                 print(error)
                 let alert = UIAlertController(title: "Oh Snap!", message: "Check Your Internet Connection and Try Again", preferredStyle: .alert)
                            
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
