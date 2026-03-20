//
//  SendVideoParticularResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 15/04/23.
//

import Foundation

struct ParticularVideoUploadModal: Codable {

    var collegeid: String?
    var staffid: String?
    var callertype: String?
    var title: String?
    var description: String?
    var iframe: String?
    var url: String?
    var isstudent: Bool?
    var isparent: Bool?
    var isstaff: Bool?
    var receiverid: String?
    var receivertype: String?
    var subjectid: String?

}

struct ParticularVideoUploadResp: Codable {

    var Status: Int?
    var Message: String?
    var data: [ParticularVideoUploadRespData]?

}

struct ParticularVideoUploadRespData: Codable {

    var ivrheader: String?

}
