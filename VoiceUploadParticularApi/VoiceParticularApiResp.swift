//
//  VoiceParticularApiResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/04/23.
//

import Foundation
import ObjectMapper


//SendFileToParticularType
class particularVoiceUploadMoad : Mappable{
    
    
    var collegeid : String!
    var staffid  : String!
    var callertype : String!
    var fileduration : String!
    var isparent : Bool!
    var filetype : String!
    var isstudent : Bool!
    var isstaff : Bool!
    var description : String!
    
    var isemergencyvoice : String!
    var subjectid : String!
    var receivertype : String!
    var receiverid : String!
    
 
  
      

    
    init(){}
    
    
    
    required init?(map: ObjectMapper.Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        collegeid <- map["collegeid"]
        staffid <- map["staffid"]
        callertype <- map["callertype"]
        fileduration <- map["fileduration"]
        isparent <- map["isparent"]
        filetype <- map["filetype"]
        isstudent <- map["isstudent"]
        isstaff <- map["isstaff"]
        description <- map["description"]
        isemergencyvoice <- map["isemergencyvoice"]
        receivertype <- map["receivertype"]
        receiverid <- map["receiverid"]
        subjectid <- map["subjectid"]
        
    }
    
    
    
    
    
    
    
    
}


class particularVoiceResponce : Mappable{
    
    
    var status: Int!
    var message: String!
    var data: [VoiceParticalrDataDetails]!

    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: ObjectMapper.Map) {
        status <- map["Status"]
        message <- map["Message"]
        data <- map["data"]
    }
    
}

class VoiceParticalrDataDetails: Mappable {

    var ivrheader: String!

    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: ObjectMapper.Map) {
        ivrheader <- map["ivrheader"]
    }
}
