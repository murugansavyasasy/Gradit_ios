//
//  ExameEditResponce.swift
//  Vs_GradItCollege
//
//  Created by admin on 14/09/23.
//

import Foundation

struct ExameEditModal: Codable {

    var examid: String?
    var colgid: String?
    var userid: String?
    var sectionid: String?
    var processtype: String?
    var subjectdetails: [ExamDetailsDataDetails]?

}

struct ExamDetailsDataDetails: Codable {

    var clgsubjectid: String?
    var examdate: String?
    var examsyllabus: String?
    var examvenue: String?
    var examsession: String?

}
