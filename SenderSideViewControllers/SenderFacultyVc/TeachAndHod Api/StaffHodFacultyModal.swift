//
//  StaffHodFacultyModal.swift
//  Vs_GradItCollege
//
//  Created by Apple on 13/06/23.
//

import Foundation
import ObjectMapper

class StaffHodFacultyModal : Mappable {
    
    
    
    
    var userid : Int!
    var appid : Int!
    var priority : String!
    var deptid : String!
    
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        userid <- map["userid"]
        appid <- map["appid"]
        priority <- map["priority"]
        deptid <- map["deptid"]
    }
    
    
}


class StaffHodFacultyResponse : Mappable {
    
   
         
    var Status : Int!
    var Message : String!
    var data : [StaffHodFacultyResponseData]!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
    }
    
    
}
class StaffHodFacultyResponseData : Mappable {
    

    var memberid : Int!
    var staffname : String!
    var facultyphoto : String!
    var stafftype : String!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        memberid <- map["memberid"]
        staffname <- map["staffname"]
        facultyphoto <- map["facultyphoto"]
        stafftype <- map["stafftype"]
    }
    
    
}
