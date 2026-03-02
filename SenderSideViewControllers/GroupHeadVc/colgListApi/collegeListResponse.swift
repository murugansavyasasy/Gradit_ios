//
//  collegeListResponse.swift
//  Vs_GradItCollege
//
//  Created by admin on 01/12/23.
//

import Foundation

import ObjectMapper



class clgListModals : Mappable{
    
    var college_id : Int!
    var user_id : String!
    var priority : String!
    
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        college_id <- map["college_id"]
        user_id <- map["user_id"]
        priority <- map["priority"]
        
    }
    
    
    
    
    
}


class clgListResponce : Mappable {
    
    var Status : Int!
    var Message : String!
    var data : [clgListDataDetails]!
    
  
   
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }
    
    
    
    
    
}


class clgListDataDetails : Mappable{
    
    var college_id : Int!
    var college_name : String!
    var isSelected : Bool!
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        college_id <- map["college_id"]
        college_name <- map["college_name"]
    }
    
    
    
    
    
    
}
