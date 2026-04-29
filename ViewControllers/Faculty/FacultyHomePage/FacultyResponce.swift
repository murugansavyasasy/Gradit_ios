//
//  FacultyResponce.swift
//  GraditFaculty
//
//  Created by MACBOOKPRO on 09/11/22.
//

import Foundation
import ObjectMapper

struct facultyModal: Codable {

    var userid: String?
    var appid: String?
    var priority: String?
    var sectionid: String?
    var semesterid: String?

}

struct facultyResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [facultyDataDetails]?

}

struct facultyDataDetails: Codable {

    var memberid: String?
    var staffname: String?
    var subjectname: String?
    var subjectcode: String?
    var stafftype: String?
    var facultyphoto: String?

}
