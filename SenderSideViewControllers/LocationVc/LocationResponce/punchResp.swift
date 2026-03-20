//
//  punchResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 31/08/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper

struct punchModal : Codable{
    
    var UserId : Int?
    var staff_or_student : String?
    var CollegeId : Int?
   
    var  deviceId : String?
    var punch_type : Int?
    var device_model : String?
}
struct punchResponce : Codable{
    
    var status : Int?
    var message : String?
}
