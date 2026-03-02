//
//  AddApiResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 16/02/23.
//

import Foundation
import ObjectMapper


class AddApiModal : Mappable{
    
    var device_token : String!
    var member_id : String!
    var mobile_no : String!
    var college_id : String!
    var priority : String!
    
    var previous_add_id : Int!
    
    
    
    init(){}
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        device_token <- map["device_token"]
        member_id  <- map["member_id"]
        mobile_no <- map["mobile_no"]
        college_id <- map["college_id"]
        priority <- map["priority"]
        previous_add_id <- map["previous_add_id"]
        
        
        
    }
    
 
    
}

class AddApiResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    
    var data : [AddDataDeatils]!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map ["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
    }
    
   
    
    
}

class AddDataDeatils : Mappable{
    
    var add_id : String!
    var add_title : String!
    var add_content : String!
    var company : String!
    var background_image : String!
    var add_image : String!
    var add_url : String!
    var video_url : String!
    var titlecolor : String!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        add_url <- map["add_url"]
        add_id <- map["add_id"]
        add_title <- map["add_title"]
        add_content <- map["add_content"]
        company <- map["company"]
        background_image <- map["background_image"]
        add_image <- map["add_image"]
        video_url <- map["video_url"]
        titlecolor <- map["titlecolor"]
        
        
    }
    
    
    
    
    
}
