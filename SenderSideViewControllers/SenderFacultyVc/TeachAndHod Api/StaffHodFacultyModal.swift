//
//  StaffHodFacultyModal.swift
//  Vs_GradItCollege
//
//  Created by Apple on 13/06/23.
//

import Foundation
import ObjectMapper

struct StaffHodFacultyModal: Codable {

    var userid: Int?
    var appid: Int?
    var priority: String?
    var deptid: String?

}

struct StaffHodFacultyResponse: Codable {

    var Status: Int?
    var Message: String?
    var data: [StaffHodFacultyResponseData]?

}

struct StaffHodFacultyResponseData: Codable {

    var memberid: Int?
    var staffname: String?
    var facultyphoto: String?
    var stafftype: String?

}
