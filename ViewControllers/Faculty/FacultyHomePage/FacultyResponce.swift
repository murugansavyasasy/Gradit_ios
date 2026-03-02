//
//  FacultyResponce.swift
//  GraditFaculty
//
//  Created by MACBOOKPRO on 09/11/22.
//

import Foundation
import ObjectMapper

class facultyModal : Mappable{
    
    var userid           : String!
    var Appid            : String!
    var priority         : String!
    var sectionid        : String!
    var semesterid       : String!
    
    
    
    init(){}
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        userid <- map["userid"]
        Appid  <- map["Appid"]
        priority <- map["priority"]
        sectionid <- map["sectionid"]
        semesterid <- map["semesterid"]
        
    }
    
    
 
    
}

class facultyResponce : Mappable{
    
    
    var Status  : Int!
    var Message : String!
    var data    : [facultyDataDetails]!
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data    <- map["data"]
    }
  
}

class facultyDataDetails : Mappable{
    
    
    var memberid : String!
    var staffname : String!
    var subjectname : String!
    var subjectcode : String!
    var stafftype   : String!
    var facultyphoto : String!
    
    
  
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        memberid <- map["memberid"]
        staffname <- map["staffname"]
        subjectname <- map["subjectname"]
        subjectcode <- map["subjectcode"]
        stafftype    <- map["stafftype"]
        facultyphoto <- map["facultyphoto"]
        
    }
    
 
}
