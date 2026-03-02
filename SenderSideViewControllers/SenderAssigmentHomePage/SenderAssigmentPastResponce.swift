//
//  SenderAssigmentPastResponce.swift
//  GraditSenderAssigment
//
//  Created by MACBOOKPRO on 30/11/22.
//

import Foundation
import ObjectMapper

class senderPastModal : Mappable{
    
    
    var userid              : String!
    var collegeid           : String!
    var departmentid        : String!
    var sectionid           : String!
    var appid               : String!
    var priority            : String!
    var type                : String!
    
    
    init(){}
    
    
       

    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
         userid                 <- map["userid"]
        collegeid               <- map["collegeid"]
        departmentid            <- map["departmentid"]
        sectionid               <- map["sectionid"]
        appid                   <- map["appid"]
        priority                <- map["priority"]
        type                    <- map["type"]
        
    }
    
 
    
}


class senderReadResponces : Mappable{
    
    
    
    var Status : Int!
    var Message : String!
    var data    : [SenderReadDataDetails]!
    
 
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status              <- map["Status"]
        Message             <- map["Message"]
        data                <- map["data"]
    }
    

}

class SenderReadDataDetails : Mappable{
    
    var assignmentid : String!
    var subjectname  : String!
    var topic        : String!
    var description  : String!
    var submissiondate : String!
    var createdon      : String!
    var sentbyname     : String!
    var createdby      : String!
    var assignmenttype : String!
    var totalcount     : String!
    var submittedcount  : String!
    var file_path       : String!
    var newfilepath     : [String] = []
    var userfilename    : String!
    var assignmentdetailid : String!
    var isappread          : String!
    var newuserfilename   : [String] = []
    
    
    
    
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        assignmentid <- map["assignmentid"]
        subjectname  <- map["subjectname"]
        topic        <- map["topic"]
        description  <- map["description"]
        submissiondate  <- map["submissiondate"]
        createdon       <- map["createdon"]
        sentbyname      <- map["sentbyname"]
        assignmenttype   <- map["assignmenttype"]
        totalcount      <- map["totalcount"]
        submittedcount   <- map["submittedcount"]
        file_path        <- map["file_path"]
        newfilepath      <- map["newfilepath"]
        userfilename     <- map["userfilename"]
        assignmentdetailid <- map["assignmentdetailid"]
        isappread            <- map["isappread"]
        newuserfilename      <- map["newuserfilename"]
    }
    
    
 
    
}

