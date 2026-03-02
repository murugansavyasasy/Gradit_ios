//
//  SemCreditDropDownResponce.swift
//  GraditSemesterCreditPoints
//
//  Created by MACBOOKPRO on 12/11/22.
//

import Foundation
import ObjectMapper

class semCreditDropDownModal : Mappable{
    
    var colgid           : String!
    var i_course_id       : String!
    
   
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        colgid   <- map["colgid"]
        i_course_id <- map["i_course_id"]
    }
    
   
}

class semCreditDropDownResponce : Mappable{
    
    
    var   Status     :     Int!
    var   Message    : String!
    var   data       : [semCreditDropDownDataDeails]!
    
    
    required init?(map: ObjectMapper.Map) {
        
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status   <- map["Status"]
        Message  <- map["Message"]
        
        data    <- map["data"]
    }
    
  
    
}

class semCreditDropDownDataDeails : Mappable{
    
    
    var  semester_id   : Int!
    var  semseter_name  : String!
    var  semester_no    : String!
    var isSelected             : Bool!
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        semester_id  <- map["semester_id"]
        semseter_name  <- map["semseter_name"]
        semester_no    <- map["semester_no"]
        
    }
    
    
    
    
    
}
