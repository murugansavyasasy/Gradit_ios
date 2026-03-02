//
//  GetSubjectWiseResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 26/03/23.
//

import Foundation
import ObjectMapper

class getSubjectWiseSectionModal: Mappable{
    
    
    var userid : String!
    var appid : String!
    var semesterid : String!
    
    init(){}
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        userid <- map["userid"]
        appid <- map["appid"]
        semesterid <- map["semesterid"]
        
        
    }
    
    
    
    
    
    
}

class getSubjectWiseResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    var data : [ getSubjectWiseDataDetails]!
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }

    
}

class getSubjectWiseDataDetails : Mappable{
    
    var sectionid : String!
    var sectionname : String!
    var subjectdetails : [getSectionDatasDetails]!
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        sectionid <- map["sectionid"]
        sectionname <- map["sectionname"]
        subjectdetails <- map["subjectdetails"]
        
        
    }
    
 
    
}

class getSectionDatasDetails : Mappable{
    
    var subjectid : String!
    var subjectname : String!
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        subjectid <- map["subjectid"]
        subjectname <- map["subjectname"]
        
        
    }
    
    
    
    
    
    
}
