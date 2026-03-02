//
//  GetCourseResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 08/03/23.
//

import Foundation
import ObjectMapper

class getCourseModal : Mappable{
   
    
    
    var user_id : String!
    var college_id : String!
    var dept_id : String!

    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        user_id <- map ["user_id"]
        college_id <- map["college_id"]
        dept_id <- map["dept_id"]
        
        
    }
    
    
}


class getCourseResponce : Mappable{
    
    var Status : Int!
    
    var Message : String!
    
    var  data : [getCourseDataDetails]!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
        
    }
    
    

    
}

class getCourseDataDetails : Mappable{
    
    var course_code : String!
    var course_name : String!
    var course_id : String!
    var isSelected : Bool!
    var department_id : Int!
    var department_name : String!
    var division_id : Int!
    var division_name : String!
   
    
   
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        course_code <- map ["course_code"]
        course_name <- map["course_name"]
        course_id <- map["course_id"]
        department_id <- map["department_id"]
        department_name <- map["department_name"]
        division_id <- map["division_id"]
        division_name <- map["division_name"]
        
    }
    

}
