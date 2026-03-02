//
//  ParticularStafResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import Foundation
import ObjectMapper

class ParticularStaffModal : Mappable {
    
    
    
    var collegeid : String!
    var staffid : String!
    var date : String!
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
        staffid <- map["staffid"]
        date <- map["date"]
    }
    
    
    
    
    
}


class particularStaffResponce : Mappable{
    
    var Status : Int!
    var Message : String!
    var data : [particualrDataDetails]!
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map ["data"]
        
        
        
    }
    
    
    
    
    
}


class particualrDataDetails : Mappable{
    
    
    
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
    var isedit   : String!
    var add_hours : [HoursdataDEtails]!
    var edit_hours : [editHoursdataDEtaild]!
    
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
        semesterid <- map["semesterid"]
        isedit <- map["isedit"]
        add_hours <- map["add_hours"]
        edit_hours <-  map["edit_hours"]
    }
    
    
    
    
    
    
}

class HoursdataDEtails : Mappable{
    
    var hour : Int!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        hour <- map["hour"]
        
    }
    
    
    
    
    
    
}
class editHoursdataDEtaild : Mappable{
    
    
    var hour : Int!
    var title : String!
    var type : String!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        hour <- map["hour"]
        title <- map["title"]
        type <- map["type"]
        
    }
    
    
}
