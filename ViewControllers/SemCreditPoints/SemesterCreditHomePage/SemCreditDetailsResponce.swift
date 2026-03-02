//
//  SemCreditDetailsResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 22/12/22.
//

import Foundation
import ObjectMapper

class semcreditDetailsModal : Mappable{
    
    
    var  colgid         :    String!
    var  i_course_id    :   String!
    var i_semester_id   :  Int!
    var i_student_id    :  String!
    
    init(){}
    
    
   
    required init?(map: ObjectMapper.Map) {
        
    mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        colgid  <- map["colgid"]
        i_course_id <- map["i_course_id"]
        i_semester_id  <- map["i_semester_id"]
        i_student_id   <- map["i_student_id"]
        
        
        
    }
    
 
    
}


class semCreditDetailsResponce : Mappable{
    
    var  Status  : Int!
    var  Message : String!
    var  data    :  [semcreditDataDetails]!
    
    
    
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
       
        Status  <- map["Status"]
        Message  <- map["Message"]
        data   <- map["data"]
        
        
        
    }
    
 
    
}


class semcreditDataDetails : Mappable{
    
    
    
    var category_id     : String!
    var category_name   : String!
    var category_list : [CategoryList]!
    
    
    var semester_name        : String!
    var total_credits  : String!
    
    var obtained        : String!
    var to_be_obtained  : String!
    
    
    
    
   
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        category_id    <- map ["category_id"]
        category_name  <- map["category_name"]
        category_list  <- map["list"]
       
        semester_name  <- map["semester_name"]
        total_credits   <- map["total_credits"]
        obtained       <- map["obtained"]
        to_be_obtained  <- map["to_be_obtained"]
        
        
    }
    
 
    
}


class CategoryList : Mappable{
    
    

  
    var category_id   : Int!
    var category_name   : String!
    var semester_name        : String!
    var total_credits  : String!
    
    var obtained        : String!
    var to_be_obtained  : String!
    
    
    
    
    
   
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        category_id    <- map ["category_id"]
        category_name  <- map["category_name"]
        semester_name  <- map["semester_name"]
        total_credits   <- map["total_credits"]
        obtained       <- map["obtained"]
        to_be_obtained  <- map["to_be_obtained"]
        
        
        
                        
    }
    
 
    
}
