//
//  collegeListResponse.swift
//  Vs_GradItCollege
//
//  Created by admin on 01/12/23.
//

import Foundation

import ObjectMapper

struct clgListModals : Codable{
    
    var college_id : Int?
    var user_id : String?
    var priority : String?
}

struct clgListResponce : Codable {
    
    var Status : Int?
    var Message : String?
    var data : [clgListDataDetails]?
}

struct clgListDataDetails : Codable{
    
    var college_id : Int?
    var college_name : String?
    var isSelected : Bool?
}
