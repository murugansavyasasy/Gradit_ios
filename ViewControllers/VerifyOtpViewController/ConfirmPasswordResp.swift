//
//  ConfirmPasswordResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 26/08/23.
//

import Foundation
import ObjectMapper


class confirmPasswordModal : Mappable{
    
    
    var mobilenumber : String!
    var newpassword  : String!
     
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        mobilenumber <- map["mobilenumber"]
        newpassword  <- map["newpassword"]
        
    }
    
    

    
}


class ConfirmPassResp : Mappable{
    
    
    var Status : Int!
    var Message : String!
    
   
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        
    }
    
    
    
    
    
    
    
}
