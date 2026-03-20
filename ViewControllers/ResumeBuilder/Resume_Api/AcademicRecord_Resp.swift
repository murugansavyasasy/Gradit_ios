//
//  AcademicRecord_Resp.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 03/07/25.
//

import Foundation
import ObjectMapper

struct EducationalDetail: Codable {

    var percentage: String?
    var classDegree: String?
    var institution: String?
    var file_path: [File]?

}

struct EducationData: Codable {

    var id: Int?
    var idMember: Int?
    var educationalDetails: [EducationalDetail]?
    var backlogs: String?
    var numberOfArrears: String?
    var isDelete: Int?

}

struct EducationResponse: Codable {

    var status: Bool?
    var message: String?
    var data: [EducationData]?

}

// MARK: - Request

struct Edit_Academic_req: Codable {

    var idMember: Int?
    var educationalDetails: [EducationalDetail]?
    var backlogs: String?
    var numberOfArrears: String?

}

// MARK: - File Model

struct File: Codable {

    var type: String?
    var url: String?

}

// MARK: - Responses

struct Edit_Academic_Response: Codable {

    var status: Bool?
    var message: String?

}

struct Edit_Skill_Response: Codable {

    var status: Bool?
    var message: String?

}
