//
//  ExamViewPageResponcess.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 27/03/23.
//

import Foundation
import ObjectMapper

struct examViewPageModal: Codable {

    var examid: String?
    var staffid: String?
    var collegeid: String?

}

struct exameViewPageResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [examviewDataDetails]?

}

struct examviewDataDetails: Codable {

    var examnm: String?
    var startdate: String?
    var enddate: String?
    var courseid: String?
    var coursename: String?
    var clgdepartmentid: String?
    var clgdepartmentname: String?
    var yearid: String?
    var yearname: String?
    var semesterid: String?
    var semestername: String?
    var clgsectionid: String?
    var clgsectionname: String?
    var examheaderid: String?
    var subjectdetails: [examViewSubjectDataDetails]?

}

struct examViewSubjectDataDetails: Codable {

    var examsubjectid: String?
    var examsubjectname: String?
    var examdate: String?
    var examsyllabus: String?
    var examvenue: String?
    var examsession: String?

}
