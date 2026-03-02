//
//  TutorResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import Foundation
import ObjectMapper

class TutorModal : Mappable {
    
    
    var collegeid : String!
    var staffid : String!
    
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
        staffid <- map["staffid"]
        
    }
    
    
    
    
    
    
}

class TutorResponce : Mappable{
    
    var Status : Int!
    var Message : String!
    var data : [TutorDataDetails]!
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map ["data"]
        
        
        
    }
    
    
    
    
    
}


class TutorDataDetails : Mappable{
    
    
    
    var courseid : String!
    var coursename : String!
    var departmentid : String!
    var departmentname : String!
    var yearid : String!
    var yearname : String!
    var sectionid : String!
    var sectionname : String!
    var semesterid : String!
    var semestername : String!
    var subjectid : String!
    var subjectname : String!
    var subjecttype : String!
    var isSelected : Bool!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        courseid <- map ["courseid"]
        coursename <- map ["coursename"]
        departmentid <- map ["departmentid"]
        departmentname <- map ["departmentname"]
        yearid <- map ["yearid"]
        yearname <- map ["yearname"]
        sectionid <- map ["sectionid"]
        sectionname <- map ["sectionname"]
        subjectid <- map ["subjectid"]
        subjectname <- map ["subjectname"]
        subjecttype <- map ["subjecttype"]
    
        semestername <- map["semestername"]
        
    }
    
    
    
    
    
    
}

