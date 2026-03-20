//
//  GetDeparmentResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/03/23.
//

import Foundation
import ObjectMapper

struct DepartmentModal : Codable{
    
    var user_id : String?
    var college_id : String?
    var div_id : String?
}

struct RepienceDeparmentResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [RepienceDeparmentDataDetails]?
}

struct RepienceDeparmentDataDetails : Codable{
    
    var department_code : String?
    var department_name : String?
    var department_id : String?
    var division_name : String?
    var division_id  : String?
    var isSelected : Bool?
}
