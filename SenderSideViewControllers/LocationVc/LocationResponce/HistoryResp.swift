//
//  HistoryResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 02/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper





class GethistoryModalReq : Mappable{
    
    var CollegeId : Int!
    var attendance_month : String!
    var userId  : Int!
    var attendance_dt  : String!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
      mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        CollegeId <- map["CollegeId"]
        attendance_month <- map["attendance_month"]
        userId <- map["userId"]
        attendance_dt <- map["attendance_dt"]
    }
    
  
    
}

class GethistoryModal : Mappable{
    
    var status : Int!
    var message : String!
    var data  : [GetHirstorydatadetails]!
    
    
    required init?(map: ObjectMapper.Map) {
      mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
    
  
    
}

class GetHirstorydatadetails : Mappable{
     
    var staffName : String!
    var date : String!
    var leave_type : String!
    var attendance_type : String!
    var in_time : String!
    var out_time : String!
    var working_hours : String!
    var staffId : Int!
  
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    
    
    func mapping(map: ObjectMapper.Map) {
        staffName <- map["staff_name"]
        date <- map["attendance_dt"]
        leave_type <- map["leave_type"]
        attendance_type <- map["attendance_type"]
        in_time <- map["in_time"]
        out_time <- map["out_time"]
        working_hours <- map["working_hours"]
        staffId <- map["staff_id"]
       
        
    }
  
}
