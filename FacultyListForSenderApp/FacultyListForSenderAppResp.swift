//
//  FacultyListForSenderAppResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/03/23.
//

import Foundation
import ObjectMapper

class FacultyListSenderApp : Mappable{
    
    
    
    
    var userid : String!
    var appid : String!
    var priority : String!
    var deptid : String!
    var courseid : String!
   
   
    init(){}
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        userid <- map["userid"]
        appid <- map["appid"]
        priority <- map ["priority"]
        deptid <- map ["deptid"]
        courseid <- map["courseid"]
        
        
        
        
        
    }
    
  
    
}


class FacultyResponce : Mappable{
    
    var Status : Int!
    
    var Message : String!
    
    var data : [facultySenderDataDetails]!
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map ["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }
    
    
    
    
    
    
    
}


class facultySenderDataDetails : Mappable{
    
    var memberid : String!
    var staffname : String!
    var facultyphoto : String!
    var  stafftype : String!
    
    
   
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        memberid <- map ["memberid"]
        staffname <- map ["staffname"]
        facultyphoto <- map ["facultyphoto"]
        stafftype <- map ["stafftype"]
        
        
    }
    
    
    
    
    
}
