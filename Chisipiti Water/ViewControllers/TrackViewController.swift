//
//  TrackViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 6/8/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD
import Reachability

class TrackViewController: UIViewController {
    
    var reachability:Reachability?
    
    @IBOutlet weak var OrderTrackingTableView: UITableView!
    @IBOutlet weak var noOrdersLbl: UILabel!
    
    
    
    
    var trackOrderData = [TrackOrder]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TrackingOrderAPICalling {
             print("Order Tracking Downloaded")
            self.OrderTrackingTableView.reloadData()
        }
        
        
        OrderTrackingTableView.isHidden = true
        noOrdersLbl.isHidden = true

      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        callingDelegates()
        
    }
    
    func callingDelegates(){
        
        OrderTrackingTableView.dataSource = self
        OrderTrackingTableView.delegate = self
        
    }
    
    func TrackingOrderAPICalling(completed: @escaping DownloadComplete){
        
        do {
            self.reachability = try Reachability.init()
        } catch {
            
            print("Unable to start nottifier")
        }
        
        if ((reachability!.connection) != .unavailable){
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            let trackOrder_endpoint = "http://tegloma.com/chisipiti_app/track_order.php?mobileno=\(UserDetails.sharedInstance.mobileno)"
            
            Alamofire.request(trackOrder_endpoint, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
                
                let result = response.result
                
                switch response.result {
                    
                case let .success(value):
                    
                    let TrackOrderJSONData = JSON(value)
                    
                    if TrackOrderJSONData["success"].boolValue == true {
                        
                        MBProgressHUD.hide(for: self.view, animated: true)
                        
                        let trackOrderJSONData = JSON(result.value!)["data"]
                        
                        print("Track Order Data: \(trackOrderJSONData)")
                        
                        for i in 0..<trackOrderJSONData.count {
                            let allTrackOrderData = TrackOrder(tackOrderDict: trackOrderJSONData[i])
                            self.trackOrderData.append(allTrackOrderData)
                            
                        }
                        
                        completed()
                        
                        self.OrderTrackingTableView.isHidden = false
                        self.noOrdersLbl.isHidden = true
                        self.OrderTrackingTableView.reloadData()
                        
                    
                    } else {
                        
                        self.OrderTrackingTableView.isHidden = true
                        self.noOrdersLbl.isHidden = false
                        
                        
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

//MARK:-  TABLEVIEW FUNCTIONS

extension TrackViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackOrderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = OrderTrackingTableView.dequeueReusableCell(withIdentifier: "OrderTrackingCell") as! OrderTrackingTableViewCell
        
        cell.configureCell(orderTrack: trackOrderData[indexPath.row])
        
        cell.backView.layer.cornerRadius = 5
        cell.backView.clipsToBounds = true
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(280/3)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           performSegue(withIdentifier: "toTrackOrderView", sender: self)
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if let destinationVC = segue.destination as? TrackOrderDataViewController {
               destinationVC.trackOrder = trackOrderData[(OrderTrackingTableView.indexPathForSelectedRow?.row)!]
               OrderTrackingTableView.deselectRow(at: OrderTrackingTableView.indexPathForSelectedRow!, animated: true)
               
           }
       }
       
    
}
