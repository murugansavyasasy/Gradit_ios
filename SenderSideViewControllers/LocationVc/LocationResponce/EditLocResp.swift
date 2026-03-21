//
//  EditLocResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 25/09/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation

struct EditLocModal : Codable{
  
    var biometric_location_id : Int?
    var location : String?
    var distance : String?
    var UserId : Int?
    var CollegeId : Int?

}

struct EditLocResponce : Codable{
    
    var status : Int?
    var message : String?
    
}
