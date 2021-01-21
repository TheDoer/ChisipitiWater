//
//  SettingsSection.swift
//  Chisipiti Water
//
//  Created by Adonis Rumbwere on 17/11/2020.
//  Copyright © 2020 LimitlessGroup. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int,CaseIterable, CustomStringConvertible {
   case Account
   case Communications
    
    var description: String{
        switch self {
        case .Account: return "Account"
        case .Communications: return "Communications"
        }
    }
}

enum AuthOptions: Int, CaseIterable, SectionType {
    case PersonalInformation
    case Logout
    
    var containsSwitch: Bool { return false }
    
    var description: String{
        switch self {
        case .PersonalInformation: return "Personal Information"
        case .Logout: return "Logout"
        }
    }
}

enum CommunicationsOptions: Int, CaseIterable, SectionType {
    case Notification
    //case ReportCrashes

    var containsSwitch: Bool {
        switch self {
        case .Notification: return false
        //case .ReportCrashes: return false
        }
    }

    var description: String {
        switch self {
        case .Notification: return "Customer Support"
        //case .ReportCrashes: return "Report Crashes and Bugs"
        }
    }
}
