//
//  ApiReadStatus.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/02/23.
//

import Foundation
import ObjectMapper

class AppReadStatusModal : Mappable{
    
    var userid : String!
    var msgtype : String!
    var detailsid : String!
    var priority : String!
    
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        userid <- map["userid"]
        msgtype <- map["msgtype"]
        detailsid <- map["detailsid"]
        priority <- map["priority"]
        
        
        
        
    }
    
    
    
    
    
}

class ReadStausApiResponce : Mappable{
    
    
    var  Status : Int!
    
    var Message : String!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
    }
    
    
    
    
    
}
