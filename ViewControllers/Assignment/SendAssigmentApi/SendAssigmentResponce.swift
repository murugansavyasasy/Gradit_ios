//
//  SendAssigmentResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 30/03/23.
//

import Foundation
import ObjectMapper

class sendAssigmentModal : Mappable{
    
    var assignmentid: String!
    var processby: String!
    var colgid : String!
    var description : String!
    var filetype: String!
    var FileNameArray : [filenamesss]!
    
    
    
    init(){}
    
    
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        assignmentid <- map["assignmentid"]
        processby <- map["processby"]
        colgid <- map["colgid"]
        description <- map["description"]
        filetype <- map["filetype"]
        FileNameArray <- map["FileNameArray"]
        
    }
    
    
    
    
}

class filenamesss : Mappable{
    
   var  FileName : String!
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map:map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        FileName <- map["FileName"]
    }
    
    
    
    
    
    
    
}



class sndAssigmentResponce : Mappable{
    
    
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
