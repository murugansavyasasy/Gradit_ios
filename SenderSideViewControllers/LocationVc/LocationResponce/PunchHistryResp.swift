//
//  PunchHistryResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation

import ObjectMapper



class punchHistryModalReq : Mappable{


var UserId : Int!
var CollegeId : Int!
var fromdate : String!
var todate : String!
var attendance_date : String!

    init(){}
required init?(map: ObjectMapper.Map) {
    mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {
    
    UserId <- map["UserId"]
    CollegeId <- map["CollegeId"]
    fromdate <- map["fromdate"]
    todate <- map["todate"]
    attendance_date <- map["attendance_date"]
}


}


class punchHistryResponce : Mappable{


var status : Int!
var message : String!
var data : [PunchHistryDataDetails]!

required init?(map: ObjectMapper.Map) {
    mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {
    
    status <- map["status"]
    message <- map["message"]
    data <- map["data"]
}


}




class PunchHistryDataDetails : Mappable{




var date : String!
var timings : [Timing] = []




required init?(map: ObjectMapper.Map) {
    mapping(map: map)
}

func mapping(map: ObjectMapper.Map) {
    date <- map ["date"]
    timings <- map ["timings"]
    
}
}

class Timing: Mappable {
    var time: String!
    var punchType: PunchType!
    var deviceModel: String!
    var deviceId: Int!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        time         <- map["time"]
        punchType    <- map["punch_type"]
        deviceModel  <- map["device_model"]
        deviceId     <- map["deviceId"]
    }
}

class PunchType: Mappable {
    var id: Int!
    var value: String!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id      <- map["id"]
        value   <- map["value"]
    }
}
