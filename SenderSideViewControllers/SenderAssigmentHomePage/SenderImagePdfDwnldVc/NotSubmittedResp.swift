//
//  NotSubmittedResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 04/03/24.
//

import Foundation
import ObjectMapper



class notSubmittedModal : Mappable{
   
    
    
    
    var assignmentid : String!
    var processby     : String!
    var submissiontype : String!
   
    init(){}
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        
        assignmentid <- map["assignmentid"]
        processby <- map["processby"]
        submissiontype <- map["submissiontype"]
        
        
    }
    
    
    
    
}

class notsubmitedModal : Mappable{
    
    
    var Status : Int!
    
    var Message : String!
    
    var data : [notSubmittedDataDetils]!
    
   
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        data    <- map["data"]
    }
    
    
    
    
    
    
}

class notSubmittedDataDetils : Mappable{
    
    
    var studentid : String!
    var assignmentdetailsid : String!
    var studentname       : String!
    var course          : String!
    var year            : String!
    var obtainedmark    : String!
    var filearray       : [String]!
    
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        studentid <- map["studentid"]
        assignmentdetailsid <- map ["assignmentdetailsid"]
        studentname <- map ["studentname"]
        course  <- map["course"]
        year  <- map["year"]
        obtainedmark <- map["obtainedmark"]
        filearray   <- map["filearray"]
    }
    
    
    
    
    
    
}
