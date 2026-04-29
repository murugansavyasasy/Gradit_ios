//
//  locationResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 29/08/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation

struct AddloactionModal : Codable{
    
    var CollegeId : Int?
    var userId : Int?
    var location : String?
    var longitude : String?
    var latitude : String?
    var distance : String?
 
}


struct addlocationResps : Codable{
    
    var status : Int?
    var message : String?
  
}
