//
//  forwardResponces.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 03/04/23.
//

import Foundation

import ObjectMapper


class forwardssModal : Mappable{
    
    var collegeid : String!
        var staffid : String!
        var callertype : String!
        var sectionid : String!
        var subjectid : String!
        var processtype : String!
        var assignmentid : String!
        var receivertype : String!
        var receiverid   : String!
        
        
        
        init(){}
        
        required init?(map: ObjectMapper.Map) {
            
            mapping(map: map)
            
        }
        
        func mapping(map: ObjectMapper.Map) {
            
            
            collegeid <- map["collegeid"]
            staffid <- map["staffid"]
            callertype <- map["callertype"]
            sectionid <- map["sectionid"]
            subjectid <- map["subjectid"]
            processtype <- map["processtype"]
            assignmentid <- map["assignmentid"]
            receivertype <- map["receivertype"]
            receiverid <- map["receiverid"]
        }
    
    
    
    
    
}

class forwardResponce : Mappable{
    
    
    
    
    var Status : Int!
    var Message : String!
    
   
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        
        
    }

    
    
    
}
