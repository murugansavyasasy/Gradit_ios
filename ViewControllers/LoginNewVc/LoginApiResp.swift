//
//  LoginApiResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 22/12/23.
//

import Foundation
import ObjectMapper



class loginNewModal : Mappable{
   
    
    
    var mobile_number : String!
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
    
        mobile_number <- map["mobile_number"]
        
    }
}



class loginNewResponse : Mappable{
    
    
    var Status : Int!
    var Message : String!
    var data : [loginNewDataDetail]!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }
    
    
    
    
    
}


class loginNewDataDetail : Mappable{
    
    var is_redirect_otp_screen : Int!
    var resultvalue : Int!
    var resultmessage : String!
   
    var  otp : String!
    var ivrnumbers : [String]!
   
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        is_redirect_otp_screen <- map["is_redirect_otp_screen"]
        resultvalue <- map["resultvalue"]
        resultmessage <- map["resultmessage"]
        otp <- map["otp"]
        ivrnumbers <- map["ivrnumbers"]
        
        
    }
    
    
    
    
    
    
}
