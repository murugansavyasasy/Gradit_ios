//
//  SendTextEntierCollegeResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/03/23.
//

import Foundation
import ObjectMapper


class EntierCollegeModal:Mappable{
    
    
    var collegeid : String!
    var staffid : String!
    var callertype : String!
    var filetype : String!
    var messagecontent : String!
    var isstudent : Bool!
    var isstaff : Bool!
    var isparent : Bool!
    var description : String!
    
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
        staffid <- map["staffid"]
        callertype <- map["callertype"]
        filetype <- map["filetype"]
        messagecontent <- map["messagecontent"]
        isstudent  <- map["isstudent"]
        isstaff <- map["isstaff"]
        isparent <- map["isparent"]
        description <- map["description"]
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
}

class EntierCollegeResponce : Mappable{
    
     
    var Status : Int!
    var Message : String!
    var data : [EntiercollegeDataDetails]!
    
   
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
        
    }
    
    
    
    
    
    
    
    
}

class EntiercollegeDataDetails : Mappable{
    
    var ivrheader : String!
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        ivrheader <- map["ivrheader"]
    }
    
    
    
    
    
    
    
}
