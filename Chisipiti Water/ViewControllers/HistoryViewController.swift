//
//  HistoryViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 4/8/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Reachability
import MBProgressHUD

class HistoryViewController: UIViewController {
    
    //var mobileNumber:String = "263774731945"
    
    var historyData = [History]()
    
    var reachability:Reachability?
    
    @IBOutlet weak var historyTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        callingDelegates()
        
        self.HistoryAPICalling {

                       print("HistoryData Downloaded")
                       self.historyTableView.reloadData()

                            }


    }
    
    
    func callingDelegates(){
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
    }
    
    
    func HistoryAPICalling(completed: @escaping DownloadComplete){
        
        let history_endpoint = "http://tegloma.com/chisipiti_app/history.php?mobileno=\(UserDetails.sharedInstance.mobileno)"
            
            Alamofire.request(history_endpoint, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
                
                let result = response.result
                let historyJSONData = JSON(result.value!)["data"]
                
                print("DATA: \(historyJSONData)")
                
                for i in 0..<historyJSONData.count {
                    
                    let allHistoryData = History(HistoryDict: historyJSONData[i])
                    self.historyData.append(allHistoryData)
                }
                
                completed()
                
                
            }
             
  
        }
    
    
    }

 //MARK:-  TABLEVIEW FUNCTIONS

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "historyCell") as! HistoryTableViewCell
        
        cell.configureCell(history: historyData[indexPath.row])
        
        cell.backView.layer.cornerRadius = 5
        cell.backView.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        

        
        return CGFloat(280/3)
    }
    
    
}





