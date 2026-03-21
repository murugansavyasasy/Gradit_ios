//
//  HistoryResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 02/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper





struct GethistoryModalReq : Codable{
    
    var CollegeId : Int?
    var attendance_month : String?
    var userId  : Int?
    var attendance_dt  : String?
 
}

struct GethistoryModal : Codable{
    
    var status : Int?
    var message : String?
    var data  : [GetHirstorydatadetails]?
 
}

struct GetHirstorydatadetails : Codable{
     
    var staff_name : String?
    var attendance_dt : String?
    var leave_type : String?
    var attendance_type : String?
    var in_time : String?
    var out_time : String?
    var working_hours : Int?
    var staff_id : Int?
  
}
