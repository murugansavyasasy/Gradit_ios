//
//  SkillSet_Resp.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 03/07/25.
//

import Foundation
import ObjectMapper

class projects: Mappable {
    
    var title: String?
    
    init(){}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        title  <- map["title"]
    }
}

class Internship: Mappable {
    var to: String?
    var from: String?
    var companyName: String?
    var designation: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        to          <- map["to"]
        from        <- map["from"]
        companyName <- map["companyName"]
        designation <- map["designation"]
    }
}

class Certification: Mappable {
    var duration: String?
    var institute: String?
    var courseName: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        duration    <- map["duration"]
        institute   <- map["institute"]
        courseName  <- map["courseName"]
    }
}

class Assessment: Mappable {
    var score: String?
    var assessment: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        score       <- map["score"]
        assessment  <- map["assessment"]
    }
}

class SkillProfile: Mappable {
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
    var createdOn: Any?
    var modifiedOn: Any?
    var isDelete: Int?

    required init?(map: Map) {}

    func mapping(map: Map) {
        id                  <- map["id"]
        idMember            <- map["idMember"]
        languages           <- map["languages"]
        softSkill           <- map["softSkill"]
        areaInterest        <- map["areaInterest"]
        internship          <- map["internship"]
        programmingLanguage <- map["programmingLanguage"]
        toolsPlatform       <- map["toolsPlatform"]
        certifications      <- map["certifications"]
        assessmentDetails   <- map["assessmentDetails"]
        projects            <- map["projects"]
        createdOn           <- map["createdOn"]
        modifiedOn          <- map["modifiedOn"]
        isDelete            <- map["isDelete"]
    }
}

class SkillProfileResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: [SkillProfile]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}

class SoftSkillsResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: [SoftSkillData]?

    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}

class SoftSkillData: Mappable {
    var softSkills: [String]?
    
    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        softSkills <- map["softSkills"]
    }
}

import Foundation
import ObjectMapper

class Edit_Skill_Req: Mappable {
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

    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        idMember            <- map["idMember"]
        languages           <- map["languages"]
        softSkill           <- map["softSkill"]
        areaInterest        <- map["areaInterest"]
        internship          <- map["internship"]
        programmingLanguage <- map["programmingLanguage"]
        toolsPlatform       <- map["toolsPlatform"]
        certifications      <- map["certifications"]
        assessmentDetails   <- map["assessmentDetails"]
        projects            <- map["projects"]
    }
}

class Internship_Request: Mappable {
    var companyName: String?
    var designation: String?
    var from: String?
    var to: String?
    var hasError: Bool = false
    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        companyName <- map["companyName"]
        designation <- map["designation"]
        from        <- map["from"]
        to          <- map["to"]
    }
}

class Certification_Request: Mappable {
    var courseName: String?
    var institute: String?
    var duration: String?
    var hasError: Bool = false
    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        courseName <- map["courseName"]
        institute  <- map["institute"]
        duration   <- map["duration"]
    }
}

class Assessment_Request: Mappable {
    var assessment: String?
    var score: String?
    var hasError: Bool = false
    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        assessment <- map["assessment"]
        score      <- map["score"]
    }
}

class Project_Request: Mappable {
    var title: String?
    var hasError: Bool = false
    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        title <- map["title"]
    }
}
