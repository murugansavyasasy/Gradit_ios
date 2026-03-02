//
//  SendVideoParticularResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 15/04/23.
//

import Foundation
import ObjectMapper



class ParticularVideoUploadModal: Mappable {

    var collegeid: String!
    var staffid: String!
    var callertype: String!
    var title: String!
    var description: String!
    var iframe: String!
    var url: String!
    var isstudent: Bool!
    var isparent: Bool!
    var isstaff: Bool!
    var receiverid: String!
    var receivertype: String!
    var subjectid : String!

    init(){}
    
    required init?(map: Map){
        
        mapping(map: map)
    }

    func mapping(map: Map) {
        collegeid <- map["collegeid"]
        staffid <- map["staffid"]
        callertype <- map["callertype"]
        title <- map["title"]
        description <- map["description"]
        iframe <- map["iframe"]
        url <- map["url"]
        isstudent <- map["isstudent"]
        isparent <- map["isparent"]
        isstaff <- map["isstaff"]
        receiverid <- map["receiverid"]
        receivertype <- map["receivertype"]
        subjectid <- map["subjectid"]
    }
}


class ParticularVideoUploadResp: Mappable {

    var status: Int!
    var message: String!
    var data: [ParticularVideoUploadRespData]!
    

    required init?(map: Map){
        mapping(map: map)
    }

    func mapping(map: Map) {
        status <- map["Status"]
        message <- map["Message"]
        data <- map["data"]
    }
}

class ParticularVideoUploadRespData: Mappable {

    var ivrheader: String!
    required init?(map: Map){
        
        mapping(map: map)
        
    }

    func mapping(map: Map) {
        ivrheader <- map["ivrheader"]
    }
}
