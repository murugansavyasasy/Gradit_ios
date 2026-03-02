//
//  punchResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 31/08/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper

class punchModal : Mappable{
    
    var UserId : Int!
    var staff_or_student : String!
    var CollegeId : Int!
   
    var  deviceId : String!
    var punch_type : Int!
    var device_model : String!


    init(){}
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        UserId <- map["UserId"]
        staff_or_student <- map["staff_or_student"]
        CollegeId <- map["CollegeId"]
        device_model <- map["device_model"]
        punch_type <- map["punch_type"]
        deviceId <- map["deviceId"]
    }

}
class punchResponce : Mappable{
    
    var status : Int!
    var message : String!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
    }
    
    
}
