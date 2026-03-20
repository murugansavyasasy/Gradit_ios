//
//  examDeleteSubResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/07/23.
//

import Foundation
import ObjectMapper

struct examDeleteModal: Codable {

    var examid: String?
    var colgid: String?
    var departmentid: String?
    var userid: String?
    var sectionid: String?
    var processtype: String?
    var subjectdetails: [String]?

}

struct deleteResp: Codable {

    var Status: Int?
    var Message: String?

}
