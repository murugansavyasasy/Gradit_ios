//
//  ManageLeaveResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/03/23.
//

import Foundation
import ObjectMapper

class manageLeaveModal : Mappable{
  
    var colgid : String!
    var memberid : String!
    var applicationid : String!
    var leavetypeid : String!
    var leavefromdate : String!
    var leavetodate : String!
    var numofdays : String!
    var clgsectionid : String!
    var leavereason : String!
    var processtype : String!
    
    
    init(){}

    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        colgid <- map ["colgid"]
        memberid <- map ["memberid"]
        applicationid <- map ["applicationid"]
        leavetypeid <- map ["leavetypeid"]
        leavefromdate <- map ["leavefromdate"]
        leavetodate <- map ["leavetodate"]
        numofdays <- map ["numofdays"]
        clgsectionid <- map["clgsectionid"]
        leavereason <- map["leavereason"]
        processtype <- map["processtype"]
        
    }
  
    
}


class manageLeaveResponce :  Mappable{
    
    
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
