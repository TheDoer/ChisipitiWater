//
//  EditProfileViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 18/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit
import Reachability
import Alamofire
import SwiftyJSON
import TextFieldEffects
import MBProgressHUD

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var FullNameLbl: HoshiTextField!
    @IBOutlet weak var MobileNumberLbl: HoshiTextField!
    @IBOutlet weak var HomeAddressLbl: HoshiTextField!
    @IBOutlet weak var NewPINLbl: HoshiTextField!
    @IBOutlet weak var ConfirmNewPassword: HoshiTextField!
    
    var reachability: Reachability?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        populateFields()
    }
    
    
    @IBAction func SaveBtn(_ sender: Any) {
        
        SaveInformation()
        
    }
    
    @IBAction func BacktoHomeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func populateFields(){
        FullNameLbl.text = "\(UserDetails.sharedInstance.name)"
        MobileNumberLbl.text = "\(UserDetails.sharedInstance.mobileno)"
        HomeAddressLbl.text = "\(UserDetails.sharedInstance.physical_address)"
    }
    
    
    func SaveInformation(){
        
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable to start Notifier")
        
    }
        if ((reachability!.connection) != .unavailable){
            
            let newPassword = NewPINLbl.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject
            
              MBProgressHUD.showAdded(to: self.view, animated: true)
            
        let saveDate_endpoint = "http://tegloma.com/chisipiti_app/settings.php?mobileno=\(UserDetails.sharedInstance.mobileno)&name=\(UserDetails.sharedInstance.name)&physical_address=\(UserDetails.sharedInstance.physical_address)&pin=\(newPassword)"
            
            print("Save Data Endpoint: \(saveDate_endpoint)")
            
            
            Alamofire.request(saveDate_endpoint,method: .post, encoding:JSONEncoding.default).responseJSON {
                           (response) in
                
                 print("Response: \(response)")
                let result = response.result
                
                switch response.result {
                    
                case let .success(value):
                    
                    let saveDataResponse = JSON(value)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    if saveDataResponse["success"].boolValue == true {
                        
                        let saveJSONdata = JSON(result.value!)["data"]
                        
                        print("LoginJSONData1: \(saveJSONdata)")
                        
                        let alert = UIAlertController(title: "Great News", message: "Profile Updated Successfully!", preferredStyle: .alert)
                                              
                        let closeAction = UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: {action in
                                               
                                                  
                           })
                               alert.addAction(closeAction)
                               self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                case let .failure(error):
                    print("Endpoint Error:\(error)")
                     let alert = UIAlertController(title: "Oh Snap!", message: "Cannot Connect to Server", preferredStyle: .alert)
                                
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

}
