//
//  fechLocationResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 03/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation


struct fechRequ : Codable{
   var  userId: Int?
   var  CollegeId : Int?
}

 
struct fechModal : Codable{
    var status : Int?
    var message : String?
    var data : [FechdataDetails]?
  
}
struct FechdataDetails : Codable{
    
    var latitude : String?
    var longitude : String?
    var location : String?
    var distance : String?
}
