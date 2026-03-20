//
//  GetDivisionResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 04/03/23.
//

import Foundation
import ObjectMapper

struct getDivisionModal : Codable{
    
    var user_id : String?
    var college_id : String?
}

struct GetDivisionResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [getDivisonDataDetails]?
}
    
struct getDivisonDataDetails : Codable{
    
    var division_code : String?
    var division_name : String?
    var division_id : String?
    var isSelected : Bool?
}
    
    

