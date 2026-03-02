//
//  CategoryResponce.swift
//  GraditCategoryCreaditPoints
//
//  Created by MACBOOKPRO on 07/11/22.
//

import Foundation
import ObjectMapper


class categoryModal : Mappable{
    
    var  colgid          : String!
    var  i_student_id    :  String!
    
    
    init(){}
    
  
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        
        colgid <- map["colgid"]
        i_student_id <- map["i_student_id"]
    }
    

}

class categoryResponce : Mappable{
    
    var Status    : Int!
    var Message   : String!
    var data      : [categoryDataDetails]!
    
    
 
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
        
    }

}

class categoryDataDetails : Mappable{
    
    
    var category_id  : String!
    var category_name : String!
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
       category_id <- map["category_id"]
        category_name <- map["category_name"]
        
        
        
    }

}
