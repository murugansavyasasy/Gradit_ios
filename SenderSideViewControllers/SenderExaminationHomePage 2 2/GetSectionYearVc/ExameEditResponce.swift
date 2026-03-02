//
//  ExameEditResponce.swift
//  Vs_GradItCollege
//
//  Created by admin on 14/09/23.
//

import Foundation


import ObjectMapper




class ExameEditModal : Mappable{
    
    
    
    
    var examid : String!
    var colgid : String!
   
    var userid : String!
    var sectionid : String!
    var processtype : String!
    var subjectdetails :[ExamDetailsDataDetails]!
    
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        examid <- map["examid"]
        colgid  <- map["colgid"]
       
        userid <- map["userid"]
        sectionid <- map["sectionid"]
        processtype <- map["processtype"]
        subjectdetails <- map ["subjectdetails"]
        
        
    }
    

    
    
    
}


class ExamDetailsDataDetails : Mappable{
    
    
    var clgsubjectid : String!
    var examdate : String!
    var examsyllabus : String!
    var examvenue : String!
    var examsession : String!
    
    
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        clgsubjectid <- map["clgsubjectid"]
        examdate     <- map["examdate"]
        examsyllabus <- map["examsyllabus"]
        examvenue    <- map["examvenue"]
        examsession   <- map["examsession"]
        
        
        
    }
    
   
    
}
