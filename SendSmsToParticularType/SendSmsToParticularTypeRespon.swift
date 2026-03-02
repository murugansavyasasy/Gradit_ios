//
//  SendSmsToParticularTypeRespon.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 16/03/23.
//

import Foundation
import ObjectMapper

class SendSmsToParticularModal : Mappable{
    
    
    var collegeid : String!
    var staffid : String!
    var callertype : String!
    var messagecontent : String!
    var description  : String!
    var receiverid : String!
    var receivertype : String!
    var isstudent : Bool!
    var isparent : Bool!
    var isstaff : Bool!
    var filetype : String!
    var subjectid : String!
    init(){}
   
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
        staffid <- map["staffid"]
        callertype <- map["callertype"]
        messagecontent <- map["messagecontent"]
        description <- map["description"]
        receiverid <- map["receiverid"]
        receivertype <- map["receivertype"]
        isstudent <- map["isstudent"]
        isparent <- map["isparent"]
        isstaff <- map["isstaff"]
        filetype <- map["filetype"]
        subjectid <- map["subjectid"]
        
    }
    
    
    
    
    
    
    
    
}


class senderParticularResponce : Mappable{
    
    
    
    
   var Status : Int!
   var Message : String!
   var data : [SmsdataDetails]!
   
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
        
    }
    
 
    
}

class SmsdataDetails : Mappable{
    
    var ivrheader : String!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        ivrheader <- map["ivrheader"]
    }
    
  
    
}
