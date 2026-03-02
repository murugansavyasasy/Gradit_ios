//
//  PutMarkResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 29/02/24.
//

import Foundation
import ObjectMapper


class  PutMarkResp : Mappable{
    
    var assignmentid : String!
    var processby : String!
    var studentid  : String!
    var assignmentdetailsid : String!
    var marks   : String!
    var ImageChage : Bool!
    
    init(){}

    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        assignmentid <- map["assignmentid"]
        processby <- map["processby"]
        studentid <- map["studentid"]
        assignmentdetailsid <- map["assignmentdetailsid"]
        marks <- map["marks"]
    }
    
    
    
    
    
    
    
}


class  PutMarkResponse : Mappable{
    
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
