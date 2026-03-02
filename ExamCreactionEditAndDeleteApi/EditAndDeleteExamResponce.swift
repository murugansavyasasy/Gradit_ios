//
//  EditAndDeleteExamResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import Foundation
import ObjectMapper

class editDeleteModal : Mappable{
    
    var collegeid : String!
    var examid : String!
    var examname : String!
    var staffid : String!
    var startdate : String!
    var enddate : String!
    var processtype : String!
    var sectiondetails : [String] = []
    
    
    init(){}

    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
        examid <- map["examid"]
        examname <- map["examname"]
        staffid <- map["staffid"]
        startdate <- map["startdate"]
        enddate <- map["enddate"]
        processtype <- map["processtype"]
        sectiondetails <- map["sectiondetails"]
        
    }
    
    
    
    
    
    
    
}

class EditAndDeletResponce : Mappable{
   
    
    var Status : Int!
    var Message : String!
    var data : [editAndDeleteDataDetails]!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
        
    }
    
    
}

class editAndDeleteDataDetails : Mappable{
    
    
    var ivrheader : String!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        ivrheader <- map["ivrheader"]
    }
    
    
    
    
    
    
}
