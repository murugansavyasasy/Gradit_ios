//
//  ExameViewResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 31/03/23.
//

import Foundation
import ObjectMapper

class examViewModal : Mappable{
    
    
    var studentid : String!
    var examheaderid : String!
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        studentid <- map["studentid"]
        examheaderid <- map["examheaderid"]
        
        
    }
    
    

    
}


class examViewResponce : Mappable{
    
    var Status : Int!
    var Message : String!
    var data : [ examViewResiverDataDetails]!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
        
    }
    
    
    
    
    
    
}


class examViewResiverDataDetails : Mappable{
    
    
    var subjectname : String!
    var marks : String!
    
    
   
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        subjectname <- map ["subjectname"]
        marks <- map ["marks"]
        
    }
    
    
    
    
    
    
    
    
}
