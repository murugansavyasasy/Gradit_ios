//
//  AttendanceDetResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 19/02/24.
//

import Foundation

struct attenanceDetailsModal: Codable {

    var userid: Int?
    var priority: String?
    var appid: Int?
    var subjectid: Int?
    var staffid: String?

}

struct attendanceDetailResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [attendanceDataDetails]?

}

struct attendanceDataDetails: Codable {

    var attended_hour_no: Int?
    var absent_hour_no: Int?
    var attended_date: String?

}
