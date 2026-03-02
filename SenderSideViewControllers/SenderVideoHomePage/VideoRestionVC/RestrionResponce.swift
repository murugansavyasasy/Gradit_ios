//
//  RestrionResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 15/05/23.
//

import Foundation

import ObjectMapper

class restionResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    
    var data : [RestionDataDetails]!
   
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }
    
    
 
    
    
}

class RestionDataDetails : Mappable{
    
    
    var content : String!
    
    required init?(map: ObjectMapper.Map) {
    
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        content <- map["content"]
    }
    
    
    
    
    
    
}
