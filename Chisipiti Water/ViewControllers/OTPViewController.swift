//
//  OTPViewController.swift
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

class OTPViewController: UIViewController {
    
    var reachability:Reachability?
    var mobileNumber:String = ""
    var OTPStatus: String = ""
    
    
    
    let backgroundImageView = UIImageView()
    let backgroundImageViewOne = UIImageView()
    
    @IBOutlet weak var FirstOTPDigitTtxt: HoshiTextField!
    @IBOutlet weak var SecondOTPDigitTtxt: HoshiTextField!
    @IBOutlet weak var ThirdOTPDigitTtxt: HoshiTextField!
    @IBOutlet weak var FourthOTPDigitTtxt: HoshiTextField!
    @IBOutlet weak var resendOTPbtn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setBackgroundOne()
        setBackground()
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func LogIntoMyAccount(_ sender: Any) {
        
        guard let one = FirstOTPDigitTtxt!.text, one.isNotEmpty,
            let two = SecondOTPDigitTtxt!.text, two.isNotEmpty,
            let three = ThirdOTPDigitTtxt!.text, three.isNotEmpty,
            let four = FourthOTPDigitTtxt!.text, four.isNotEmpty
        
        else {
                simpleAlert(title: "Oops!", msg: "Please fill all OTP fields")
                 return
        }
        
        OTPCallingAPI()
        
    }
    
    
    
    @IBAction func resendOTPbtn(_ sender: Any) {
        
        OTPCallingAPI()
        
    }
    
    
    
    func OTPCallingAPI(){
        
        do {
            self.reachability = try Reachability.init()
        }catch {
            print("Unable to start notifier")
        }
        
        if((reachability!.connection) != .unavailable){
            
            let first = FirstOTPDigitTtxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            let second = SecondOTPDigitTtxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            let third = ThirdOTPDigitTtxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            let fourth = FourthOTPDigitTtxt!.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
          
            let OTP_endpoint = "http://tegloma.com/chisipiti_app/verifyOTP.php?mobileno=\(self.mobileNumber)&otp=\(first)\(second)\(third)\(fourth)"
            
            print("URL:\(OTP_endpoint)")
            
            if let encoded = OTP_endpoint.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                let url = URL(string: encoded) {
                
                Alamofire.request(url, method: .post, headers: nil).validate().responseJSON { (response) in
                    
                    print(response)
                    
                    let result = response.result
                    
                    switch response.result {
                        
                    case let .success(value):
                        
                        let OTPData = JSON(value)
                        
                        print(" Data:\(OTPData)")
                        
                        self.OTPStatus = JSON(result.value!)["data"][0]["registration_status"].stringValue
                        
                        if OTPData["success"].boolValue == true {
                            
                            MBProgressHUD.hide(for: self.view, animated: true)
                            
                            //Segue to the success view here
                            let SetUpAccountVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SetUpAccountVC") as! SetUpAccountViewController
                            
                             SetUpAccountVC.modalPresentationStyle = .fullScreen
                            self.present(SetUpAccountVC, animated: true)
                            
                        } else {
                            
                            let alert = UIAlertController(title: "Oops!", message: "\(self.OTPStatus)", preferredStyle: .alert)
                                                  
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

