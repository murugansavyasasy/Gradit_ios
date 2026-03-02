//
//  AttendanceAbesentResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 02/04/23.
//

import Foundation
import ObjectMapper

class attendanceAbesentModal : Mappable{
    
    
    var userid : Int!
    var priority : String!
    var appid : Int!
    
    
   
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        userid <- map["userid"]
        priority <- map["priority"]
        appid <- map["appid"]
        
        
    }

}


class attendanceAbsentResponce : Mappable{
    
    var Status : Int!
    var Message : String!
    var data : [attendanceAbesentDataDetails]!
    
    
    
   
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
        
    }
    
    
    
    
    
    
}

class attendanceAbesentDataDetails : Mappable{
    
    
    var subjectname : String!
    var staff_name : String!
    var attended_hour : String!
    var absent_hour    : String!
    var subject_id   : Int!
    var staff_id   : Int!
    var total_hour : Int!
    var percentage : String!
  
    
   
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        subjectname <- map["subjectname"]
        staff_name <- map["staff_name"]
        attended_hour <- map["attended_hour"]
        absent_hour <- map["absent_hour"]
        subject_id <- map["subject_id"]
        staff_id <- map["staff_id"]
        total_hour <- map["total_hour"]
        percentage <- map["percentage"]
    }
    
    
    
    
    
}

