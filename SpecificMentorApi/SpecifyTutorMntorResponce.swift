//
//  SpecifyTutorMntorResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import Foundation

struct GetMentorstudentListforappModal: Codable {

    var collegeid: String?
    var staffid: String?
//    var deptid: String?
    var yearid: String?
    var sectionid: String?

}

struct GetMentorstudentListforappResponse: Codable {

    var Status: Int?
    var Message: String?
    var data: [GetMentorstudentListData]?

}

struct GetMentorstudentListData: Codable {

    var name: String?
    var memberid: String?
    var admissionno: String?
    var regno: String?
    var course: String?
    var year: String?
    var section: String?
    var isSelected: Bool?

}
