//
//  SendVideoToEntierResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import Foundation
import ObjectMapper

class SendVideoEntierModal : Mappable{
    
    
    var collegeid : String!
    var staffid : String!
    var callertype : String!
    var title : String!
    var description : String!
    var iframe : String!
    var url : String!
    var isstudent : String!
    var isparent : String!
    var isstaff : String!
     
    
   
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
        staffid <- map["staffid"]
        callertype <- map["callertype"]
        title <- map["title"]
        description <- map["description"]
        iframe <- map["iframe"]
        url <- map["url"]
        isstudent <- map["isstudent"]
        isparent <- map["isparent"]
        isstaff <- map["isstaff"]
        
    }
    
    

    
}


class sendVideoToEntierResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    var data : [ sendVideoToEntierDataDetails]!
    
   

    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message  <- map["Message"]
        data <- map["data"]
        
        
    }
    
    
    
    
    
    
    
}

class sendVideoToEntierDataDetails : Mappable{
    
    
    var  ivrheader : String!

    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        ivrheader <- map["ivrheader"]
    }
    
    
    
    
    
    
    
}
