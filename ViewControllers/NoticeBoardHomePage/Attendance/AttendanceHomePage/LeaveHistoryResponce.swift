//
//  LeaveHistoryResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 23/02/23.
//

import Foundation
import ObjectMapper

class leaveRequestModal : Mappable{


var collegeid : String!
var staffid : String!



init(){}

required init?(map: ObjectMapper.Map) {
    mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {
    
    collegeid <- map["collegeid"]
    staffid <- map["staffid"]
    
    
}




}

class leaveResponce : Mappable{


var Status : Int!
var Message : String!
var data : [leaveDataDetails]!





required init?(map: ObjectMapper.Map) {
    
    mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {
    
    Status <- map["Status"]
    Message <- map["Message"]
    data  <- map["data"]
    
    
}





}


class leaveDataDetails : Mappable{



var createdon : String!
var applicationid : String!
var leaveapplicationtype : String!
var leavefromdate : String!
var leavetodate : String!
var numofdays : String!
var leavereason : String!
var leavestatus : String!
var leavestatusid : String!





required init?(map: ObjectMapper.Map) {
    mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {
    
    createdon <- map["createdon"]
    applicationid <- map ["applicationid"]
    leaveapplicationtype <- map ["leaveapplicationtype"]
    leavefromdate <- map["leavefromdate"]
    leavetodate <- map ["leavetodate"]
    numofdays <- map ["numofdays"]
    leavereason <- map ["leavereason"]
    leavestatus <- map ["leavestatus"]
    leavestatusid <- map ["leavestatusid"]
    
    
    
    
    
}




}


