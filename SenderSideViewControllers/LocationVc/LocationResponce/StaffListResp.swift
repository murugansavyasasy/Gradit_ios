//
//  StaffListResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 04/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper




struct staffListModalReq : Codable{

    var CollegeId : Int?

}



struct staffListModal : Codable{
    
    
    var status : Int?
    var message : String?
    var data : [ModaldataDetails]?
  
}
struct ModaldataDetails : Codable{
    
    
    var staff_id : Int?
    var staff_name : String?

}
