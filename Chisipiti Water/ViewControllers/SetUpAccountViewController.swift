//
//  SetUpAccountViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 27/7/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit

class SetUpAccountViewController: UIViewController {
    
    let backgroundImageView = UIImageView()
    let backgroundImageViewOne = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setBackgroundOne()
        setBackground()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
