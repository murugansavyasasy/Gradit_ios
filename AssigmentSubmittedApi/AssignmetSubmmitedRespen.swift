//
//  AssignmetSubmmitedRespen.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/04/23.
//

import Foundation
import ObjectMapper

class AssigmentSummitedModal : Mappable{
    
    var assignmentid : String!
    var processby : String!
    var filetype : String!
    
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        assignmentid <- map["assignmentid"]
        processby <- map["processby"]
        filetype <- map["filetype"]
        
    }
    
    
    
    
    
}

class AssigmentSubmitResponce : Mappable{
    
    
    var status: Int!
        var message: String!
        var data: [AssignmentSubDataDetail]!

    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }

func mapping(map: ObjectMapper.Map) {
            status <- map["Status"]
            message <- map["Message"]
            data <- map["data"]
        }
    
    
    
    
}


class AssignmentSubDataDetail : Mappable{
    
    var content: String!
    var description: String!
        var submittedtime: String!
        var file_name: String!

    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    func mapping(map: ObjectMapper.Map) {
            content <- map["content"]
            description <- map["description"]
            submittedtime <- map["submittedtime"]
        file_name <- map["file_name"]
        }
    
    
    
}
