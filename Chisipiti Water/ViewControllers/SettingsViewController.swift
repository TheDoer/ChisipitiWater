//
//  SettingsViewController.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 16/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SettingsCell"

class SettingsViewController: UIViewController {
    
     // MARK: - Properties
    
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Helper Functions
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
    
    func configureUI() {
           configureTableView()
           
           navigationController?.navigationBar.prefersLargeTitles = true
           navigationController?.navigationBar.isTranslucent = false
           navigationController?.navigationBar.barStyle = .black
           navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
           navigationItem.title = "Settings"
       }
 
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .Account: return AuthOptions.allCases.count
       case .Communications: return CommunicationsOptions.allCases.count
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsTableViewCell
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Account:
            let auth = AuthOptions(rawValue: indexPath.row)
            cell.sectionType = auth
        case .Communications:
            let communications = CommunicationsOptions(rawValue: indexPath.row)
            cell.sectionType = communications
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         guard let section = SettingsSection(rawValue: indexPath.section) else { return  }
        
        switch section {
        case .Account:
            let auth = AuthOptions(rawValue: indexPath.row)
            
            if (AuthOptions(rawValue: indexPath.row)?.description) == "Personal Information" {
                
                let EditProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EditProfileVC")
                EditProfileVC.modalPresentationStyle = .fullScreen
                self.present(EditProfileVC, animated: true)
                
            } else {
                
                let EditProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginViewController")
                //EditProfileVC.modalPresentationStyle = .fullScreen
                self.present(EditProfileVC, animated: true)
            }
           
            print(AuthOptions(rawValue: indexPath.row)?.description)
            
        case .Communications:
            let communications = CommunicationsOptions(rawValue: indexPath.row)
            
             //(CommunicationsOptions(rawValue: indexPath.row)?.description) == "Customer Support"
            
            let EditProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CustomerSupportVC")
             EditProfileVC.modalPresentationStyle = .fullScreen
            self.present(EditProfileVC, animated: true)
                
        
            
            print(CommunicationsOptions(rawValue: indexPath.row)?.description)
            
            
           
        }
        
      
    }
    
    
}
