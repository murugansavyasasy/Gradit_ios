//
//  AssigmentMemberCountResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 05/04/23.
//

import Foundation
import ObjectMapper

class assigmentMemberCountModal : Mappable{
    
    
    var assignmentid : String!
    var processby : String!
    var submissiontype : String!
    
   

    init(){}
    
    required init?(map: ObjectMapper.Map) {
        
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        assignmentid <- map["assignmentid"]
        processby <- map["processby"]
        submissiontype <- map["submissiontype"]
        
    }
    
 
}


class assigmentMemberCountResponce : Mappable{
   
    
    var Status: Int!
        var message: String!
        var data: [AssigmentmebCountData]!

    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        message <- map["message"]
        data <- map["data"]
        
    }
    
    
    
    
}


class AssigmentmebCountData : Mappable{
    
    
        var studentid: String!
        var assignmentdetailsid : String!
        var obtainedmark : String!
        var filearray : [FilepathDataDetails]!
        var studentname: String!
    var year : String!
     
    var course : String!
    var ImageShow : Bool!
    var register_number : String!
               
                
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        studentid <- map["studentid"]
                studentname <- map["studentname"]
        assignmentdetailsid <- map["assignmentdetailsid"]
               
        obtainedmark <- map["obtainedmark"]
        filearray <- map["filearray"]
        year <- map["year"]
        course <- map["course"]
        register_number <- map ["register_number"]
        
    }
    
    
    
    
    
    
}

class FilepathDataDetails : Mappable{
    
    var fileurl : String!
    
    var filetype : String!
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
        
        
    }
    
    func mapping(map: ObjectMapper.Map) {
        fileurl <- map["fileurl"]
        filetype <- map["filetype"]
    }
    
    
    
    
}
