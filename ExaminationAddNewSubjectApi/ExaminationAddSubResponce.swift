//
//  ExaminationAddSubResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import Foundation

struct Main: Codable {

    var collegeid: String?
    var examid: String?
    var examname: String?
    var staffid: String?
    var startdate: String?
    var enddate: String?
    var processtype: String?
    var departmentid: String?
    var sectiondetails: [Sectiondetails]?

}

struct Sectiondetails: Codable {

    var clgsectionid: Int?
    var Subjectdetails: [Subjectdetails]?

}

struct Subjectdetails: Codable {

    var examsubjectid: String?
    var examdate: String?
    var examsyllabus: String?
    var examvenue: String?
    var examsession: String?

}

struct ExaminationAddResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [Datass]?

}

struct Datass: Codable {

    var ivrheader: String?

}
