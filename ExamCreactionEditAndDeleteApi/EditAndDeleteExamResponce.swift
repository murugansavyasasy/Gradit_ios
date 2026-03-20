//
//  EditAndDeleteExamResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import Foundation
import ObjectMapper

struct editDeleteModal: Codable {

    var collegeid: String?
    var examid: String?
    var examname: String?
    var staffid: String?
    var startdate: String?
    var enddate: String?
    var processtype: String?
    var sectiondetails: [String]?

}

struct EditAndDeletResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [editAndDeleteDataDetails]?

}

struct editAndDeleteDataDetails: Codable {

    var ivrheader: String?

}
