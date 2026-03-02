//
//  ChatForntPageResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 23/12/22.
//

import Foundation
import ObjectMapper

class ChatFrontPageModal : Mappable{
    
    
    
    var student_id : String!
    var college_id : String!
    
    
   
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        student_id <- map["student_id"]
        college_id <- map["college_id"]
        
        
    }
    
 
    
}

class ChatFrontPageResponce : Mappable{
    
    
    var  Status  : Int!
    var  Message : String!
    var  data    : [chatFrontPageDataDetails]!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
        
        
        
        
    }
    
   
    
}

class chatFrontPageDataDetails : Mappable{
    
    
    var subjectid : String!
    var subjectname : String!
    var staffid    : String!
    var staffname  : String!
    var isclassteacher : String!
    var sectionid     : String!
    var subjectcount  : String!
    
   
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        subjectid <- map["subjectid"]
        subjectname <- map["subjectname"]
        staffid <- map["staffid"]
        staffname <- map["staffname"]
        isclassteacher <- map["isclassteacher"]
        sectionid <- map["sectionid"]
        subjectcount <- map["subjectcount"]
        
    }
    
 
}
