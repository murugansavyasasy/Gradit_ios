//
//  OverResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/02/23.
//

//
//  OverAllCountResponce.swift
//  GraditNoticeBoard
//
//  Created by MACBOOKPRO on 27/10/22.
//

import Foundation
import ObjectMapper

class  overAllModa : Mappable{
    
    var  userid            : String!
    var  menuid         :   String!
    var  collegeid     : String!
    var  departmentid  : String!
    var  sectionid     : String!
    var  appid   :String!
    var  priority   : String!
  
    
    
    
   
    
    
    
    init(){}
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        userid <- map["userid"]
        menuid <- map["menuid"]
        collegeid <- map["collegeid"]
        departmentid <- map["departmentid"]
        sectionid  <- map["sectionid"]
        appid    <- map["appid"]
        priority   <- map["priority"]
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}

class overAllResponc : Mappable{
    
    
    var  Status   : Int!
    var  Message  : String!
    var  data    : [overAllDataDetail]!
    
    
    
    
          
    
    
    
    required init?(map: Map) {
        
    mapping(map: map)
        
    }
    
    func mapping(map: Map) {
        
        Status  <- map["Status"]
        Message <- map["Message"]
        data    <- map["data"]
        
    }
    
    
    
    
    
    
    
}

class overAllDataDetail : Mappable{
    
    var message    : String!
    var reminders : String!
    var read   : String!
    var unread  : String!
    var upcomingexams   : String!
    var pastexams  : String!
    var upcomingassignment   : String!
    var pastassignment    : String!
    var departmentcircular   : String!
    var collegecircular : String!
    var departmentnotice : String!
    var collegenotice   : String!
    var upcomingevents : String!
    var pastevents : String!
    var video : String!
   
    
    
    
    
    
    
   
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        message                             <- map["message"]
        reminders                           <- map["reminders"]
        read                                <- map["read"]
        unread                              <- map["unread"]
        upcomingexams                       <- map["upcomingexams"]
        pastexams                           <- map["pastexams"]
        upcomingassignment                  <- map["upcomingassignment"]
        pastassignment                      <- map["pastassignment"]
        departmentcircular                  <- map["departmentcircular"]
        collegecircular                     <- map["collegecircular"]
        departmentnotice                    <- map["departmentnotice"]
        collegenotice                       <- map["collegenotice"]
        upcomingevents                      <- map["upcomingevents"]
        pastevents                          <- map["pastevents"]
        video                               <- map["video"]
    }
    
    
    
    
    
    
    
}

