//
//  AddApiResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 16/02/23.
//

import Foundation
import ObjectMapper


struct AddApiModal : Codable{
    
    var device_token : String?
    var member_id : Int?
    var mobile_no : String?
    var college_id : Int?
    var priority : String?
    var previous_add_id : Int?
}

struct AddApiResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [AddDataDeatils]?
    
}

struct AddDataDeatils : Codable{
    
    var add_id : String?
    var add_title : String?
    var add_content : String?
    var company : String?
    var background_image : String?
    var add_image : String?
    var add_url : String?
    var video_url : String?
    var titlecolor : String?
}
