//
//  AttendancecheckResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/04/23.
//

import Foundation
import ObjectMapper


class attendanceCheckModal : Mappable{
    
    
    var sectionid : String!
    var subjectid : String!
    var date    : String!
    
    init(){}

    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        sectionid <- map["sectionid"]
        subjectid <- map["subjectid"]
        date <- map["date"]
    }
    
    
    
    
    
    
}

class attendanceCheckResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        
    }
    
    
    
    
    
}
