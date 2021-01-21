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
    var responseMessage:String = ""
    
    
    
    
    let backgroundImageView = UIImageView()
    let backgroundImageViewOne = UIImageView()
    
    @IBOutlet weak var FullNameTxt: HoshiTextField!
    @IBOutlet weak var AddressTxt: HoshiTextField!
    @IBOutlet weak var MobileNumberTtxt: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.r
        
        setBackgroundOne()
        setBackground()
    }
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func createAccountBtn(_ sender: Any) {
        
        guard let name = FullNameTxt!.text, name.isNotEmpty,
        let address = AddressTxt!.text, address.isNotEmpty,
        let mobileNumber = MobileNumberTtxt!.text, mobileNumber.isNotEmpty else {
                              simpleAlert(title: "Oops!", msg: "Please fill all registration fields")
                               return
                      }
        
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
            
            let  fullName = FullNameTxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            let  mobileNumber = MobileNumberTtxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            let  address = AddressTxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            
            
            let register_endpoint =
            "http://tegloma.com/chisipiti_app/registration.php/?mobileno=\(mobileNumber)&name=\(fullName)&physical_address=\(address)"
            
                
                if let encoded = register_endpoint.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                let url = URL(string: encoded)
                    
                 {
                     Alamofire.request(url,method: .post, headers: nil).validate().responseJSON { (response) in
                         print(response)
        
                
                print("\(response)")
                
                let result = response.result
                
                switch response.result {
                    
                case let .success(value):
                    
                    let SignUpData = JSON(value)
                    
                     print(" Data:\(SignUpData)")
                    
                    
                    UserDetails.sharedInstance.signUp_Status = JSON(result.value!)["data"][0]["registration_status"].stringValue
                    
                    if SignUpData["success"].boolValue == true {
                        
                        
                         MBProgressHUD.hide(for: self.view, animated: true)
                        
                        let OTPVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "OTPVC") as! OTPViewController
                         OTPVC.mobileNumber = mobileNumber as! String
                         OTPVC.modalPresentationStyle = .fullScreen
                        self.present(OTPVC, animated: true)
                        
                        
                    }
                        
                    else {
                        
                        let alert = UIAlertController(title: "Oops!", message: "\(UserDetails.sharedInstance.signUp_Status)", preferredStyle: .alert)
                                              
                        let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: {action in
                                               
                                                  
                           })
                               alert.addAction(closeAction)
                               self.present(alert, animated: true, completion: nil)
                           }
                                       
                                                           
                    
                    
                    
                case let .failure(error):
                    print(error)
                    
                    let alert = UIAlertController(title: "Oh Snap!", message: "Check your internet connection and try again", preferredStyle: .alert)
                                
                                let closeAction = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.cancel, handler: {action in
                                    print("Close")
                                    
                                })
                     
                                alert.addAction(closeAction)
                                self.present(alert, animated: true, completion: nil)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    
                }
                
                
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
