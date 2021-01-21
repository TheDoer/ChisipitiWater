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
    
    
    @IBOutlet weak var noHistoryLbl: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    
    
    var historyData = [History]()
    var reachability:Reachability?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.HistoryAPICalling {
        print("HistoryData Downloaded")
        self.historyTableView.reloadData()

    }
        
        historyTableView.isHidden = true
        noHistoryLbl.isHidden = true
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        callingDelegates()
        
    
    }
    
    
    
    
    func callingDelegates(){
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
    }
    
    
    func HistoryAPICalling(completed: @escaping DownloadComplete){
        
        do {
            
            self.reachability = try Reachability.init()
        } catch {
            
            print("Unable to start notifier")
        }
        
        if ((reachability!.connection) != .unavailable){
            
             MBProgressHUD.showAdded(to: self.view, animated: true)
            
        
        let history_endpoint = "http://tegloma.com/chisipiti_app/history.php?mobileno=\(UserDetails.sharedInstance.mobileno)"
            
            Alamofire.request(history_endpoint, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
                
                
                let result = response.result
                
                switch response.result {
                    
                case let .success(value):
                    
                    let HistoryJSONData = JSON(value)
                    
                    if HistoryJSONData["success"].boolValue == true {
                        
                         MBProgressHUD.hide(for: self.view, animated: true)
                        
                        let historyJSONData = JSON(result.value!)["data"]
                        
                        print("DATA: \(historyJSONData)")
                        
                        for i in 0..<historyJSONData.count {
                            
                            let allHistoryData = History(HistoryDict: historyJSONData[i])
                            self.historyData.append(allHistoryData)
                        }
                        
                        completed()
                        
                        self.historyTableView.isHidden = false
                        self.noHistoryLbl.isHidden = true
                        self.historyTableView.reloadData()
                        
                    } else {
                        
                        self.historyTableView.isHidden = true
                        self.noHistoryLbl.isHidden = false
                        
                        
                    }
                    
                    
                
                case let .failure(error):
                    print(error)
                    
                    let alert = UIAlertController(title: "Oh Snap!", message: "Check your internet connection and try again", preferredStyle: .alert)
                    
                    let closeAction = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.cancel, handler: {action in
                         print("Close")
                                                                             
                                                                              
                                                                          }
                    )
                    
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





