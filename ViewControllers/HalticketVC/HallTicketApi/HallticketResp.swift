//
//  HallticketResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 14/12/23.
//

import Foundation
import ObjectMapper

class HallticketModal : Mappable{
    
    var i_course_id : Int!
    var colgid : Int!
    var i_semester_id : Int!
    var i_student_id : Int!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        i_course_id <- map["i_course_id"]
        colgid <- map["colgid"]
        i_semester_id <- map["i_semester_id"]
        i_student_id <- map["i_student_id"]
        
        
        
        
    }
    
    
    
}


class HallticketResponce : Mappable{
    
    var Status : Int!
    var Message : String!
    var data : [HallticketDataDetails]!
    
  
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }
    
    
    
    
    
    
}


class HallticketDataDetails : Mappable{
    
    
    var course_code : String!
    var course_name : String!
    var department : String!
    var dob : String!
    var register_number : String!
    var student_name : String!
    var current_sem : String!
    var subject_sem_number : String!
    var subject_code: String!
    var subject_name : String!
    var exam_date : String!
    var exam_time : String!
    var arrear_regular : String!
    var course_wise_attendance : String!
    var overall_semester_attendance : String!
    var condonation_paid : String!
    var student_image : String!
    var college_logo  : String!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        course_code <- map["course_code"]
        course_name <- map["course_name"]
        department <- map["department"]
        dob <- map["dob"]
        register_number <- map["register_number"]
        student_name <- map["student_name"]
        current_sem <- map["current_sem"]
        subject_sem_number <- map["subject_sem_number"]
        subject_code <- map["subject_code"]
        subject_name <- map["subject_name"]
        exam_date <- map["exam_date"]
        exam_time <- map["exam_time"]
        arrear_regular <- map["arrear_regular"]
        course_wise_attendance <- map["course_wise_attendance"]
        overall_semester_attendance <- map["overall_semester_attendance"]
        condonation_paid <- map["condonation_paid"]
        student_image <- map["student_image"]
        college_logo  <- map["college_logo"]
    }

    
}
