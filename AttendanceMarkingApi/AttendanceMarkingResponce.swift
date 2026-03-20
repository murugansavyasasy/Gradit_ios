//
//  AttendanceMarkingResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 04/04/23.
//

import Foundation
import ObjectMapper

struct attendanceMarkigModal: Codable {

    var collegeid: String?
    var sectionid: String?
    var subjectid: String?
    var userid: String?
    var date: String?
    var processtype: String?
    var attendance_hours: String?
    var type: String?
    var title: String?
    var presentlist: [presentListDataDetails]?
    var absentlist: [absentlistdataDetails]?
    var odlist: [onDutylistdataDetails]?
    var leavelist: [onLeavelistdataDetails]?

}

struct presentListDataDetails: Codable {

    var presentmemberid: String?

}

struct absentlistdataDetails: Codable {

    var absentmemberid: String?

}

struct onDutylistdataDetails: Codable {

    var odmemberid: String?

}

struct onLeavelistdataDetails: Codable {

    var leavememberid: String?

}

struct MarkAttendanceResponce: Codable {

    var Status: Int?
    var Message: String?

}
