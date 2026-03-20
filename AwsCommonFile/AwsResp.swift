//
//  AwsResp.swift
//  VoicesnapSchoolApp
//
//  Created by admin on 24/12/24.
//  Copyright © 2024 Gayathri. All rights reserved.
//

import Foundation

import ObjectMapper

struct AwsResps: Codable {
    
    var status : Int
    var message : String?
    var data : AwsData?
}

struct AwsData : Codable {
    
    var presignedUrl : String?
    var fileUrl : String?

}





