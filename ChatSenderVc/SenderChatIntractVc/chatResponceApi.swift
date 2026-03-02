//
//  chatResponceApi.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import Foundation
import ObjectMapper


class IntractApiModal : Mappable{
    
    var staff_id : String!
    var college_id : String!
    
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        staff_id <- map["staff_id"]
        college_id <- map["college_id"]
        
    }
    
    
    
    
    
    
    
    
}



class IntractChatResponces: Mappable {

    var status: Int!
    var message: String!
    var data: [intractChatData]!

    required init?(map: Map){
        mapping(map: map)
    }

    func mapping(map: Map) {
        status <- map["Status"]
        message <- map["Message"]
        data <- map["data"]
    }
}

class intractChatData: Mappable {

    var courseid: String!
    var coursename: String!
    var yearid: String!
    var yearname: String!
    var departmentid: String!
    var departmentname: String!
    var semesterid: String!
    var semestername: String!
    var sectionid: String!
    var sectionname: String!
    var subjectid: String!
    var subjectname: String!
    var isclassteacher: String!

    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: Map) {
        courseid <- map["courseid"]
        coursename <- map["coursename"]
        yearid <- map["yearid"]
        yearname <- map["yearname"]
        departmentid <- map["departmentid"]
        departmentname <- map["departmentname"]
        semesterid <- map["semesterid"]
        semestername <- map["semestername"]
        sectionid <- map["sectionid"]
        sectionname <- map["sectionname"]
        subjectid <- map["subjectid"]
        subjectname <- map["subjectname"]
        isclassteacher <- map["isclassteacher"]
    }
}

