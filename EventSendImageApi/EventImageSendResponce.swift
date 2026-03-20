//
//  EventImageSendResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 30/03/23.
//

import Foundation

struct EventImageModal: Codable {

    var collegeid: String?
    var eventheaderid: String?
    var Userid: String?
    var FileNameArray: [FileNames]?

}

struct FileNames: Codable {

    var FileName: String?

}

struct EventImageSendResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [sendImageEventDataDetails]?

}

struct sendImageEventDataDetails: Codable {

    var ivrheader: String?

}
