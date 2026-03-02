//
//  GetLeaveTypeResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/03/23.
//

import Foundation
import ObjectMapper

class GetLeaveTypeModal : Mappable{
    
    
    var appid : String!
    var userid : String!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        appid <- map["appid"]
        userid <- map["userid"]
        
    }
    
 
}


class GetLeaveTypeResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    var data : [GetLeaveDataDetails]!
   
        
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        
        Status <- map ["Status"]
        Message <- map ["Message"]
        data <- map ["data"]
        
        
    }
    
    
    
    
    
    
    
}

class GetLeaveDataDetails : Mappable{
    
    
    var leavetypeid : String!
    var leavetypename : String!
    
  
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        leavetypeid <- map["leavetypeid"]
        leavetypename <- map["leavetypename"]
        
    }
    
    
    
    
    
    
    
}
