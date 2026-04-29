//
//  PunchHistryResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation

struct punchHistryModalReq : Codable{
    
    var UserId : Int?
    var CollegeId : Int?
    var fromdate : String?
    var todate : String?
    
}

struct punchHistryResponce : Codable{
    
    var status : Int?
    var message : String?
    var data : [PunchHistryDataDetails]?
    
}

struct PunchHistryDataDetails : Codable{
    
    var date : String?
    var timings : [Timing] = []
    
}

struct Timing: Codable {
    var time: String?
    var punch_type: PunchType?
    var device_model: String?
    var deviceId: Int?
}

struct PunchType: Codable {
    var id: Int?
    var value: String?
}
