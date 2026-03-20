//
//  deleteResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 02/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation
import ObjectMapper





struct getLatModelReq : Codable{
    
    var CollegeId : Int?
        
}


struct getLatModel : Codable{

    var status : Int?
    var message : String?
    var data : [GetLatModaldataDetails]?
    
}


struct GetLatModaldataDetails : Codable{
    
    var id : Int?
    var latitude : String?
    var longitude : String?
    var location : String?
    var distance : String?
}



