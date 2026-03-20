//
//  SkillSet_Resp.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 03/07/25.
//

import Foundation

struct projects: Codable {

    var title: String?

}

struct Internship: Codable {

    var to: String?
    var from: String?
    var companyName: String?
    var designation: String?

}

struct Certification: Codable {

    var duration: String?
    var institute: String?
    var courseName: String?

}

struct Assessment: Codable {

    var score: String?
    var assessment: String?

}

struct SkillProfile: Codable {

    var id: Int?
    var idMember: Int?
    var languages: String?
    var softSkill: String?
    var areaInterest: String?
    var internship: [Internship]?
    var programmingLanguage: String?
    var toolsPlatform: String?
    var certifications: [Certification]?
    var assessmentDetails: [Assessment]?
    var projects: [projects]?
    var isDelete: String?

}

struct SkillProfileResponse: Codable {

    var status: Bool?
    var message: String?
    var data: [SkillProfile]?

}

struct SoftSkillsResponse: Codable {

    var status: Bool?
    var message: String?
    var data: [SoftSkillData]?

}

struct SoftSkillData: Codable {

    var softSkills: [String]?

}

// MARK: - Request Models

struct Edit_Skill_Req: Codable {

    var idMember: Int?
    var languages: String?
    var softSkill: [String]?
    var areaInterest: [String]?
    var internship: [Internship_Request]?
    var programmingLanguage: [String]?
    var toolsPlatform: [String]?
    var certifications: [Certification_Request]?
    var assessmentDetails: [Assessment_Request]?
    var projects: [Project_Request]?

}

struct Internship_Request: Codable {

    var companyName: String?
    var designation: String?
    var from: String?
    var to: String?
    var hasError: Bool?

}

struct Certification_Request: Codable {

    var courseName: String?
    var institute: String?
    var duration: String?
    var hasError: Bool?

}

struct Assessment_Request: Codable {

    var assessment: String?
    var score: String?
    var hasError: Bool?

}

struct Project_Request: Codable {

    var title: String?
    var hasError: Bool?

}
