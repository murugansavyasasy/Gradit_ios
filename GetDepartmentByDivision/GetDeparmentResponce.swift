//
//  GetDeparmentResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/03/23.
//

import Foundation
import ObjectMapper

class DepartmentModal : Mappable{
    
    
    var user_id : String!
    var college_id : String!
    var div_id : String!
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        user_id <- map["user_id"]
        college_id <- map["college_id"]
        div_id <- map["div_id"]
        
        
    }
    

    
}

class RepienceDeparmentResponce : Mappable{
    
    
    var Status : Int!
    
    var Message : String!
    
    var data : [RepienceDeparmentDataDetails]!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map ["data"]
        
        
    }
    
    
    
    
    
    
}

class RepienceDeparmentDataDetails : Mappable{
    
    
    var department_code : String!
    var department_name : String!
    var department_id : String!
    var division_name : String!
    var division_id  : String!
    var isSelected : Bool!
   
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        department_code <- map["department_code"]
        department_name <- map["department_name"]
        department_id  <- map["department_id"]
        division_id   <- map["division_id"]
        division_name <- map["division_name"]
        
    }
    
 
    
}
