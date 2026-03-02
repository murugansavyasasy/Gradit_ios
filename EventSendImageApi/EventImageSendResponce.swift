//
//  EventImageSendResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 30/03/23.
//

import Foundation
import ObjectMapper

class EventImageModal : Mappable{
    
    var collegeid : String!
    var eventheaderid : String!
    var Userid : String!
    var FileNameArray : [FileNames]!
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
        eventheaderid <- map["eventheaderid"]
        Userid <- map ["Userid"]
        FileNameArray <- map["FileNameArray"]
        
        
        
    }
    
    
    
    
    
    
    
}


class FileNames : Mappable{
    
    
    var FileName : String!
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        FileName <- map["FileName"]
    }
    
    
    
    
    
    
    
}

class EventImageSendResponce : Mappable{
    
    var Status : Int!
    var Message : String!
    var data : [sendImageEventDataDetails]!
    
    
    
   
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map ["Status"]
        Message <- map["Message"]
        data <- map ["data"]
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}


class sendImageEventDataDetails : Mappable{
    
    
    var ivrheader : String!
    
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        ivrheader <- map["ivrheader"]
        
    }
    
    
    
    
}
