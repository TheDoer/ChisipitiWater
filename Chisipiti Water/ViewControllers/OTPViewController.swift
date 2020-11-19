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
    
    let backgroundImageView = UIImageView()
    let backgroundImageViewOne = UIImageView()
    
    
    @IBOutlet weak var FirstDigitOTPTxt: HoshiTextField!
    
    @IBOutlet weak var SecondDigitOTPTxt: HoshiTextField!
    
    @IBOutlet weak var ThirdDigitOTPTxt: HoshiTextField!
    
    @IBOutlet weak var FourthDigitOTPTxt: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setBackgroundOne()
        setBackground()
    }
    
    
    func OTPCallingAPI(){
        
        do {
            self.reachability = try Reachability.init()
        }catch {
            print("Unable to start notifier")
        }
        
        if((reachability!.connection) != .unavailable){
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
          
            let OTP_endpoint = "http://tegloma.com/chisipiti_app/registration.php?mobileno=263775462869&otp=5073"
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

