//
//  AttendanceDetResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 19/02/24.
//

import Foundation
import ObjectMapper


class attenanceDetailsModal : Mappable{



var userid : Int!
var priority : String!
var appid     : Int!
var subjectid : Int!
var staffid   : String!

init(){}


required init?(map: ObjectMapper.Map) {
    mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {
    
    userid <- map["userid"]
    priority <- map["priority"]
    appid <- map["appid"]
    subjectid <- map["subjectid"]
    staffid <- map["staffid"]
    
    
}

}


class attendanceDetailResponce : Mappable{


var Status : Int!
var Message : String!
var data : [attendanceDataDetails]!

init(){}


required init?(map: ObjectMapper.Map) {
    mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {
    
    
    Status <- map["Status"]
    
    Message <- map["Message"]
    data    <- map["data"]
}

}


class attendanceDataDetails : Mappable{

var attended_hour_no : Int!
var absent_hour_no  : Int!
var attended_date   : String!


required init?(map: ObjectMapper.Map) {
    mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {
    
    attended_hour_no <- map["attended_hour_no"]
    absent_hour_no  <- map["absent_hour_no"]
    attended_date   <- map["attended_date"]
}

}
