//
//  VoiceHstryResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 05/02/24.
//

import Foundation

import ObjectMapper
class VoiceHstryModal : Mappable{
    
    var collegeid : String!
    var staffid  : String!
    var callertype : String!
    var description : String!
    var isemergencyvoice : String!
    var isstudent : Bool!
    var isparent : Bool!
    var isstaff : Bool!
    var forwarding_voice_id : String!
    var receiverid  : String!
    var receivertype : String!
    var subjectid : String!
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
        staffid <- map["staffid"]
        callertype <- map["callertype"]
        description <- map["description"]
        isemergencyvoice <- map["isemergencyvoice"]
        isstudent <- map["isstudent"]
        isparent <- map["isparent"]
        isstaff <- map["isstaff"]
        forwarding_voice_id <- map["forwarding_voice_id"]
        receiverid <- map["receiverid"]
        receivertype <- map["receivertype"]
        subjectid <- map["subjectid"]
    }
    
    
}

class voiceHstryResponce : Mappable{
    
    
    var Status : Int!
    var Message : String!
    var data : [voiceHstryDataDetails]!
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        Status <- map["Status"]
        Message <- map["Message"]
        data <- map["data"]
    }
    
    
    
}
class voiceHstryDataDetails : Mappable{
    
    var ivrheader : String!
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        
        ivrheader <- map["ivrheader"]
    }
    
}
