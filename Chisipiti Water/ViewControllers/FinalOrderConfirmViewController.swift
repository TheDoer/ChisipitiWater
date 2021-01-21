//
//  FinalOrderConfirmViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 13/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit
import Reachability

class FinalOrderConfirmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func GoToTrackOrder(_ sender: Any) {
        
        let TrackVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TrackVC")
        TrackVC.modalPresentationStyle = .overCurrentContext
        self.present(TrackVC, animated: true)
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
