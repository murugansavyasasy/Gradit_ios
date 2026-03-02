//
//  verifyOTPResponce.swift
//  Vs_GradItCollege
//
//  Created by admin on 25/08/23.
//

import Foundation

import ObjectMapper


class recentOTPModal : Mappable{
    
    
    var  mobilenumber : String!
       var otp : String!

    init(){}
    
    
    
    
    required init?(map: Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        
        mobilenumber <- map["mobilenumber"]
        otp      <- map["otp"]
        
        
    }
    
    
    
    
    
    
    
}


 
class recentOTPResponce : Mappable{
    
    var Status : Int!
    
    var Message : String!
    
    

    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        
    }
    
    
    
    
    
    
    
}
