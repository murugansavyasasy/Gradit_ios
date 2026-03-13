//
//  DeleteResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 09/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation

struct deleteModal : Codable{
   
    
    var CollegeId : Int?
    var locationId : Int?
    var userId : Int?
 
}
struct deletResponce : Codable {

    var  status : Int?
    var message : String?
}
