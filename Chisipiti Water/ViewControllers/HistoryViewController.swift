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
    
    var mobileNumber:String = "263774731945"
    
    var historyData = [History]()
    var reachability:Reachability?
    
    @IBOutlet weak var historyTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        historyTableView.dataSource = self
        historyTableView.delegate = self
        
        HistoryAPICalling()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func HistoryAPICalling(){
        
        do {
            self.reachability = try Reachability.init()
        } catch {
            print("Unable to start notifier")
        }
        
        if((reachability!.connection) != .unavailable){
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            
            let history_endpoint = "http://tegloma.com/chisipiti_app/history.php?mobileno=\(self.mobileNumber)"
            
            Alamofire.request(history_endpoint, method: .get).responseJSON { (historyResponse) in
                
                //print("History Response: \(historyResponse)")
                
                let result = historyResponse.result
                let historyJSON = JSON(result.value!)
                
                print("History Response: \(historyResponse)")
                
                for i in 0..<historyJSON.count {
                    
                    let allHistory = History(HistoryDict: historyJSON[i])
                    self.historyData.append(allHistory)
                    
                    print("Volume: \(allHistory.volume)")
                    print("Address: \(allHistory.address)")
                    print("Date: \(allHistory.orderDate)")
                    
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                
                DispatchQueue.main.async{
                 self.historyTableView.reloadData()
                                       
                }
                
            
                
            }
            
        }
        
    }
    
    
    
    
    

}

extension HistoryViewController: UITableViewDelegate,UITableViewDataSource {



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyData.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "historycell", for: indexPath) as? HistoryTableViewCell
        
        //cell?.addressTxt.text = historyData[indexPath.row].address
        //cell?.volumeTxt.text = historyData[indexPath.row].volume
        
        
        return cell!
        
        
        
    }



}
