//
//  GetCourseResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 08/03/23.
//

import Foundation
import ObjectMapper

struct getCourseModal : Codable{
   
    var user_id : String?
    var college_id : String?
    var dept_id : String?
}

struct getCourseResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var  data : [getCourseDataDetails]?
}

struct getCourseDataDetails : Codable{
    
    var course_code : String?
    var course_name : String?
    var course_id : String?
    var isSelected : Bool?
    var department_id : String?
    var department_name : String?
    var division_id : String?
    var division_name : String?
}
