//
//  GetSubjectWiseResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 26/03/23.
//

import Foundation

struct getSubjectWiseSectionModal: Codable {

    var userid: String?
    var appid: String?
    var semesterid: String?

}

struct getSubjectWiseResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [getSubjectWiseDataDetails]?

}

struct getSubjectWiseDataDetails: Codable {

    var sectionid: String?
    var sectionname: String?
    var subjectdetails: [getSectionDatasDetails]?

}

struct getSectionDatasDetails: Codable {

    var subjectid: String?
    var subjectname: String?

}
