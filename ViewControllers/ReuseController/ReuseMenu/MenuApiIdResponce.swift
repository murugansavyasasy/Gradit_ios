//
//  MenuApiIdResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/12/22.
//

import Foundation
import ObjectMapper
class menuApiIdModal: Mappable{
    
    
    var college_id     : String!
    var user_id    :  String!
    var priority      : String!
   
    
   
    init(){}
   
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        college_id  <- map["college_id"]
        user_id  <- map["user_id"]
        priority     <- map["priority"]
      
        
        
        
    }
    
 
}


class menuApiIdResponce : Mappable{
    
    
    var Status     : Int!
    var Message    : String!
    var data       : [menuApiDataDetails]!
    
    
    
    
  
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status  <- map["Status"]
        Message  <- map["Message"]
        data     <- map["data"]
        
    }
 
}

class menuApiDataDetails : Mappable{
    
    var is_read_enabled    :  Int!
    var is_write_enabled   : Int!
    var menu_id   : Int!
    var menu_name : String!
    var menu_slug : String!
    var order_id : Int!
    var parent_id : Int!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        is_read_enabled  <- map["is_read_enabled"]
        is_write_enabled <- map["is_write_enabled"]
        menu_id <- map["menu_id"]
        menu_name <- map["menu_name"]
        menu_slug <- map["menu_slug"]
        order_id <- map["order_id"]
        parent_id <- map["parent_id"]
        
    }
    
    
    
    
    
    
    
}
