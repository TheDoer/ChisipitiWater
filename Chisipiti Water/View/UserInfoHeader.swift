//
//  UserInfoHeader.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 16/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

import UIKit

class UserInfoHeader: UIView {
    
    // MARK: - Properties
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "ironman")
        return iv
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UserDetails.sharedInstance.name)"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UserDetails.sharedInstance.mobileno)"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addrressLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UserDetails.sharedInstance.physical_address)"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           
           let profileImageDimension: CGFloat = 45
           
           addSubview(profileImageView)
           profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
           profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
           profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
           profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
           profileImageView.layer.cornerRadius = profileImageDimension / 2
           
           addSubview(usernameLabel)
           usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
           usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
           
           addSubview(emailLabel)
           emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
           emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
           addSubview(addrressLabel)
           addrressLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 25).isActive = true
           addrressLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        
        
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
