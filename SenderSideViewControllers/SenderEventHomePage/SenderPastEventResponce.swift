//
//  EventsResponce.swift
//  EventsGradit
//
//  Created by MACBOOKPRO on 29/10/22.
//

import Foundation
import ObjectMapper
class senderPastEventModal : Mappable{
    
    
    var userid   :  String!
    var appid    : String!
    var priority : String!
    var type     : String!
  
    init(){}
    
    
   
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        userid  <- map["userid"]
        appid   <- map["appid"]
        priority <- map["priority"]
        type     <- map["type"]
        
        
        
    }
    

    
}

class senderPastEventResponce : Mappable{
    
    
    
    
    var  Status        : Int!
    var  Message       : String!
    var  data          :[SenderPastEventsdatadetails]!
  
    
    
    
    
    required init?(map: Map) {
        
            mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status   <- map["Status"]
        Message  <- map["Message"]
        data     <- map["data"]
        
        
        
        
    }
 
    
}


class SenderPastEventsdatadetails : Mappable{
    
    
    var  eventid          : String!
    var  event_date       : String!
    var  event_time       : String!
    var  topic            : String!
    var  body             : String!
    var  venue            : String!
    var  createdbyname    : String!
    var  createdby        : String!
    var  filepath         : String!
    var  eventdetailsid   : String!
    var  isappread        : String!
    var  newfilepath      : [String] = []
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        eventid                     <- map["eventid"]
        event_date                  <- map["event_date"]
        event_time                  <- map["event_time"]
        topic                       <- map["topic"]
        body                        <- map["body"]
        venue                       <- map["venue"]
        createdbyname               <- map["createdbyname"]
        createdby                   <- map["createdby"]
        filepath                    <- map["filepath"]
        eventdetailsid              <- map["eventdetailsid"]
        isappread                   <- map["isappread"]
        newfilepath                 <- map["newfilepath"]
    }
    
  
    
}


