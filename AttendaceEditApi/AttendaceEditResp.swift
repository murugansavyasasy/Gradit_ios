//
//  AttendaceEditResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/04/23.
//

import Foundation
import ObjectMapper

struct attendanceEditModal: Codable {

    var sectionid: String?
    var subjectid: String?
    var userid: String?
    var appid: String?
    var date: String?
    var attendancehour: String?

}

struct attendanceEditResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [AttendanceEditDataDEtails]?

}

struct AttendanceEditDataDEtails: Codable {

    var memberid: String?
    var attendancetype: String?
    var membername: String?
    var rollno: String?
    var admissionno: String?
    var isSelected: Bool?

}
