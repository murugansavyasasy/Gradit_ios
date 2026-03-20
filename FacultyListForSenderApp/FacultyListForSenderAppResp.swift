//
//  FacultyListForSenderAppResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 20/03/23.
//

import Foundation

struct FacultyListSenderApp: Codable {

    var userid: String?
    var appid: String?
    var priority: String?
    var deptid: String?
    var courseid: String?

}

struct FacultyResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [facultySenderDataDetails]?

}

struct facultySenderDataDetails: Codable {

    var memberid: String?
    var staffname: String?
    var facultyphoto: String?
    var stafftype: String?

}
