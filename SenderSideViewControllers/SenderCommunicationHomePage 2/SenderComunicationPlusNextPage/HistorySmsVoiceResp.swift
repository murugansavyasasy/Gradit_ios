//
//  HistorySmsVoiceResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 29/01/24.
//

import Foundation
import ObjectMapper


class HistorySmsVoiceModal : Mappable{
   
    
    
   
    var userid : String!
    var priority : String!
    var appid  : String!
    
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        userid <- map["userid"]
        priority <- map ["priority"]
        appid <- map["appid"]
        
    }
}


class HistorySmsVoiceResponce : Mappable{
    
    var Status : Int!
    var Message : String!
    var data    : [HistorySmsVoiceDataDetail]!
   
    required init?(map: ObjectMapper.Map) {
        
    mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }
    
    
    
    
}


class HistorySmsVoiceDataDetail : Mappable{
    
    
    var headerid : String!
    var timing   : String!
    var msgcontent : String!
    var description : String!
    var duration : String!
    var voicefile : String!
    
  
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        headerid <- map["headerid"]
        timing <- map["timing"]
        msgcontent <- map["msgcontent"]
        description <- map["description"]
        duration <- map["duration"]
        voicefile <- map["voicefile"]
    }
    
    
    
    
}
