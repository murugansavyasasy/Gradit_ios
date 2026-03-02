//
//  ExamDetailsResponce.swift
//  ExamApplicationDetails
//
//  Created by MACBOOKPRO on 05/11/22.
//

import Foundation
import ObjectMapper

class examDetailsModal : Mappable{
    
    
    
    var  i_course_id        : String!
    var  colgid             : String!
    var  i_semester_id      : String!
    var  i_student_id       : String!
    
    
    
    
    init(){}
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        i_course_id  <- map["i_course_id"]
        colgid       <- map["colgid"]
        i_semester_id  <- map["i_semester_id"]
        i_student_id   <- map["i_student_id"]
        
        
        
    }
    
 
    
}


class examDetailsResponce : Mappable{
    
    var   Status     : Int!
    var   Message    : String!
    var   data       : [examesDataDetails]!
    
    
    
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status   <- map["Status"]
        Message  <- map["Message"]
        data    <- map["data"]
        
    }
    
    
  
}

class examesDataDetails : Mappable{
    
    
    var    sem_number          :  String!
    var    subject_code        :  String!
    var    subject_name        :  String!
    var    amount              :  String!
      
   
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        sem_number       <- map["sem_number"]
        subject_code     <- map["subject_code"]
        subject_name     <- map["subject_name"]
        amount           <- map["amount"]
        
       
       
        
    }
  
    
    
}
