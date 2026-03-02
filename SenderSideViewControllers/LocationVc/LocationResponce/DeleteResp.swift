//
//  DeleteResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 09/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper

class deleteModal : Mappable{
   
    
    var CollegeId : Int!
    var locationId : Int!
    var userId : Int!
    init(){}
    

    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        CollegeId <- map["CollegeId"]
        locationId <- map["locationId"]
        userId <- map["userId"]
    }
    
    
}
class deletResponce : Mappable {
   
    
    
    var  status : Int!
    var message : String!

    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map ["status"]
        message <- map ["message"]
    }
}
