//
//  OverAllCountResponce.swift
//  GraditNoticeBoard
//
//  Created by MACBOOKPRO on 27/10/22.
//

import Foundation
import ObjectMapper

struct  overAllModal : Codable{
    var  userid : String?
    var  menuid : String?
    var  collegeid : String?
    var  departmentid : String?
    var  sectionid : String?
    var  appid   :String?
    var  priority : String?
}

struct overAllResponce : Codable{
    var  Status : Int?
    var  Message : String?
    var  data : [overAllDataDetails]?
    
}

struct overAllDataDetails : Codable{
    
    var message    : String?
    var reminders : String?
    var read   : String?
    var unread  : String?
    var upcomingexams   : String?
    var pastexams  : String?
    var upcomingassignment   : String?
    var pastassignment    : String?
    var departmentcircular   : String?
    var collegecircular : String?
    var departmentnotice : String?
    var collegenotice   : String?
    var upcomingevents : String?
    var pastevents : String?
    var video : String?
    
}
