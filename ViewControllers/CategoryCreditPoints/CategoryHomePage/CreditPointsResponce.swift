//
//  CreditPointsResponce.swift
//  GraditCategoryCredit
//
//  Created by MACBOOKPRO on 08/11/22.
//

import Foundation
import ObjectMapper

class creditModal : Mappable{
    
    
    var colgid      : String!
    var i_course_id : String!
    var i_category_id : String!
    var i_student_id : String!
    
    
    init (){}
   
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        colgid <- map["colgid"]
        i_course_id <- map["i_course_id"]
        i_category_id <- map["i_category_id"]
        i_student_id <- map["i_student_id"]
        
        
    }
    
  
    
}

class creditResponce : Mappable{
    
    
    var   Status  : Int!
    var   Message : String!
    var   data  : [creditDataDetails]!
    
    
    
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
        
    }
    

    
}


class creditDataDetails : Mappable{
    
    var category_id : String!
    var category_name : String!
    var semester_name : String!
    var total_credits : String!
    var obtained      : String!
    var to_be_obtained : String!
    
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        category_id <- map["category_id"]
        category_name <- map["category_name"]
        semester_name  <- map["semester_name"]
        total_credits   <- map["total_credits"]
        obtained       <- map["obtained"]
        to_be_obtained  <- map["to_be_obtained"]
        
        
    }
    
    
  
    
    
}
