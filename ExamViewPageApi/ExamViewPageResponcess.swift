//
//  ExamViewPageResponcess.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import Foundation
import ObjectMapper

class examViewPageModal: Mappable{
    
    var examid : String!
    var staffid : String!
    var collegeid : String!
    
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
       examid <- map["examid"]
        staffid <- map["staffid"]
        collegeid <- map["collegeid"]
        
        
    }
    
    
    
    
    
    
}


class exameViewPageResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    var data : [examviewDataDetails]!
    
   
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        
        data <- map["data"]
        
        
        
        
    }
    

    
}


class examviewDataDetails : Mappable{
    
    var examnm : String!
    var startdate : String!
    var enddate : String!
    var courseid : String!
    var coursename : String!
    var clgdepartmentid : String!
    var clgdepartmentname : String!
    var yearid : String!
    var yearname : String!
    var semesterid : String!
    var semestername : String!
    
    var clgsectionid : String!
    var clgsectionname : String!
    var examheaderid : String!
    var subjectdetails : [examViewSubjectDataDetails]!
   
    
    
    
  
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        examnm <- map["examnm"]
        startdate <- map["startdate"]
        enddate <- map["enddate"]
        courseid <- map["courseid"]
        coursename <- map["coursename"]
        clgdepartmentid <- map["clgdepartmentid"]
        clgdepartmentname <- map["clgdepartmentname"]
        yearid <- map["yearid"]
        yearname <- map["yearname"]
        semesterid <- map["semesterid"]
        semestername <- map["semestername"]
        clgsectionid <- map["clgsectionid"]
        clgsectionname <- map["clgsectionname"]
        examheaderid <- map["examheaderid"]
        subjectdetails <- map["subjectdetails"]
        
    }
    
    
    
    
    
    
    
}


class examViewSubjectDataDetails : Mappable{
    
    
    var examsubjectid : String!
    var examsubjectname : String!
    var examdate : String!
    var examsyllabus : String!
    var examvenue : String!
    var examsession : String!
    
    
    
   
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        examsubjectid <- map["examsubjectid"]
        examsubjectname <- map["examsubjectname"]
        examdate <- map["examdate"]
        examsyllabus <- map["examsyllabus"]
        examvenue <- map["examvenue"]
        examsession <- map["examsession"]
        
    }
    
    
    
    
    
    
}
