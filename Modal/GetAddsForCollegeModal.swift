//
//  GetAddsForCollegeModal.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 04/11/22.
//

import Foundation
import ObjectMapper


class GetAddsForCollegeModal : Mappable {
    
    
  
    
    var device_token : String!
    var member_id : String!
    var mobile_no : String!
    var college_id : String!
    var priority : String!
    var previous_add_id : String!

    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        device_token <- map["device_token"]
        member_id <- map["member_id"]
        mobile_no <- map["mobile_no"]
        college_id <- map["college_id"]
        priority <- map["priority"]
        previous_add_id <- map["previous_add_id"]
    }
    
    
    
}





class GetAddsForCollegeResponse : Mappable {
    
    
  
    
    var Status : Int!
    var Message : String!
    var data : [GetAddsForCollegeData]!
   
    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
   
        
    }
    
    
    
}





class GetAddsForCollegeData : Mappable {
    
    
  
    
    var add_id : String!
    var add_title : String!
    var add_content : String!
    var company : String!
    var background_image : String!
    var add_image : String!

    var add_url : String!
    var video_url : String!
    var titlecolor : String!

    
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        add_id <- map["add_id"]
        add_title <- map["add_title"]
        add_content <- map["add_content"]
        company <- map["company"]
        background_image <- map["background_image"]
        add_image <- map["add_image"]
        add_url <- map["add_url"]
        video_url <- map["video_url"]
        titlecolor <- map["titlecolor"]
        
    }
    
    
    
}
