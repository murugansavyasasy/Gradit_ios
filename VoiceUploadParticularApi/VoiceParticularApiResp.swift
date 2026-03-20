//
//  VoiceParticularApiResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/04/23.
//

import Foundation
import ObjectMapper

struct particularVoiceUploadMoad: Codable {

    var collegeid: String?
    var staffid: String?
    var callertype: String?
    var fileduration: String?
    var isparent: Bool?
    var filetype: String?
    var isstudent: Bool?
    var isstaff: Bool?
    var description: String?
    var isemergencyvoice: String?
    var subjectid: String?
    var receivertype: String?
    var receiverid: String?

}

struct particularVoiceResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [VoiceParticalrDataDetails]?

}

struct VoiceParticalrDataDetails: Codable {

    var ivrheader: String?

}
