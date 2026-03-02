//
//  examDeleteSubResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/07/23.
//

import Foundation
import ObjectMapper

class examDeleteModal : Mappable{
  
    
    
    
    var examid : String!
    var colgid : String!
    var departmentid : String!
    var userid : String!
    var sectionid : String!
    var processtype : String!
    var subjectdetails : [String] = []
    
   
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        
        examid <- map ["examid"]
        colgid <- map["colgid"]
        departmentid <- map["departmentid"]
        userid <- map["userid"]
        sectionid <- map["sectionid"]
        processtype <- map["processtype"]
        subjectdetails <- map["subjectdetails"]
    }
    
    
}
class deleteResp : Mappable{
   
    
    
    var Status : Int!
    var Message : String!
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        Status <- map ["Status"]
        Message <- map["Message"]
        
    }
}
