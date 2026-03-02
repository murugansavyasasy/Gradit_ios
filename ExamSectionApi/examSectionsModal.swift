//
//  examSectionsModal.swift
//  Vs_GradItCollege
//
//  Created by Apple on 26/06/23.
//

import Foundation
import ObjectMapper


class examSectionss : Mappable{
    
    var examid : String!
    
    var sectionid : String!
    
    init(){}
    
    
    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: Map) {
       examid <- map["examid"]
        sectionid <- map["sectionid"]
        
    }
  
}


class examRepons : Mappable{
    
    
    var Status : String!
    var sectionid : String!
    var data  : [examDataDetail]!
    
    
    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: Map) {
        Status <- map["Status"]
        sectionid <- map["sectionid"]
        data <- map["data"]
        
    }
}

class examDataDetail : Mappable{
    
    var examsubjectid : String!
    var examsubjectname : String!
    var examdate : String!
    var examsyllabus : String!
    var examvenue  : String!
    var examsession : String!
    
    
    
    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: Map) {
        
        examsubjectid <- map["examsubjectid"]
        examsubjectname <- map["examsubjectname"]
        examdate <- map["examdate"]
        examsyllabus <- map["examsyllabus"]
        examvenue <- map["examvenue"]
        examsession <- map["examsession"]
        
    }
    
}
