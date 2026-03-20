//
//  EventParticularResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 18/03/23.
//

import Foundation
import ObjectMapper

struct EventParticualrModal: Codable {

    var eventid: String?
    var collegeid: String?
    var staffid: String?
    var eventdate: String?
    var eventtime: String?
    var eventbody: String?
    var eventvenue: String?
    var receiveridlist: String?
    var isstudent: Bool?
    var isstaff: Bool?
    var isparent: Bool?
    var receivertype: String?
    var Callertype: String?
    var subjectid: String?
    var eventtopic: String?
    var processtype: String?

}

struct EventParticularResponce: Codable {

    var Status: Int?
    var Message: String?

}
