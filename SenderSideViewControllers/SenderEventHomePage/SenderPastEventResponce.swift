//
//  EventsResponce.swift
//  EventsGradit
//
//  Created by MACBOOKPRO on 29/10/22.
//

import Foundation

struct senderPastEventModal: Codable {

    var userid: String?
    var appid: String?
    var priority: String?
    var type: String?

}

struct senderPastEventResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [SenderPastEventsdatadetails]?

}

struct SenderPastEventsdatadetails: Codable {

    var eventid: String?
    var event_date: String?
    var event_time: String?
    var topic: String?
    var body: String?
    var venue: String?
    var createdbyname: String?
    var createdby: String?
    var filepath: String?
    var eventdetailsid: String?
    var isappread: String?
    var newfilepath: [String]?

}
