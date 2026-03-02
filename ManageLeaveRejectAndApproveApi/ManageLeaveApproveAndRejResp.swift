//
//  ManageLeaveApproveAndRejResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 24/03/23.
//

import Foundation
import ObjectMapper



class mangaeLeaveModal:Mappable{
    
    
    
    var leaveid : String!
    var userid : String!
    var processtype : String!
    
    init(){}

    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        leaveid <- map["leaveid"]
        userid <- map["userid"]
        processtype <- map["processtype"]
        
        
        
    }
    
    
    
    
    
    
    
}


class manageLeaveResponces :Mappable{
    
    
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
