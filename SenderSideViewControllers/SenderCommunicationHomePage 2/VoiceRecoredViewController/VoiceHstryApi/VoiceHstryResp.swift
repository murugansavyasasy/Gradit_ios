//
//  VoiceHstryResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 05/02/24.
//

import Foundation

import ObjectMapper

struct VoiceHstryModal : Codable{
    
    var collegeid : String?
    var staffid  : String?
    var callertype : String?
    var description : String?
    var isemergencyvoice : String?
    var isstudent : Bool?
    var isparent : Bool?
    var isstaff : Bool?
    var forwarding_voice_id : String?
    var receiverid  : String?
    var receivertype : String?
    var subjectid : String?
}

struct voiceHstryResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [voiceHstryDataDetails]?
}

struct voiceHstryDataDetails : Codable{
    
    var ivrheader : String?
    
}
