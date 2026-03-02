//
//  ResumeGenerate_Resp.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 16/07/25.
//

import Foundation

import Foundation
import ObjectMapper

class TemplateResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: [TemplateData]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}

class TemplateData: Mappable {
    var template: [ResumeTemplate]?
    var themecolor: [String]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        template    <- map["template"]
        themecolor  <- map["themecolor"]
    }
}

class ResumeTemplate: Mappable {
    var resumeTemplateName: String?
    var resumeTemplateImage: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        resumeTemplateName  <- map["resume_template_name"]
        resumeTemplateImage <- map["resume_template_image"]
    }
}


import Foundation
import ObjectMapper

class ResumeRequest: Mappable {
    var context: ResumeContext?
    var templateNumber: Int?
    var themeColor: String?
    var bucket: String?
    var bucketPath: String?
    var idMember: Int?

    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        context        <- map["context"]
        templateNumber <- map["templateNumber"]
        themeColor     <- map["themeColor"]
        bucket         <- map["bucket"]
        bucketPath     <- map["bucketPath"]
        idMember       <- map["idMember"]
    }
}

class ResumeContext: Mappable {
    var name: String?
    var email: String?
    var phone: String?
    var address: String?
    var skills: [String]?
    var education: [EducationalDetail]?
    var internship: [Internship]?
    var areainterest: [String]?
    var softSkill: [String]?
    var certifications: [Certification]?
    var languages: [String]?
    var projects: [projects]?

    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        name          <- map["name"]
        email         <- map["email"]
        phone         <- map["phone"]
        address       <- map["address"]
        skills        <- map["skills"]
        education     <- map["education"]
        internship    <- map["internship"]
        areainterest  <- map["areainterest"]
        softSkill     <- map["softSkill"]
        certifications <- map["certifications"]
        languages     <- map["languages"]
        projects      <- map["projects"]
    }
}

class Education: Mappable {
    var `class`: String?
    var degree: String?
    var percentage: String?
    var institution: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        `class`     <- map["class"]
        degree      <- map["degree"]
        percentage  <- map["percentage"]
        institution <- map["institution"]
    }
}

class Experience: Mappable {
    var designation: String?
    var company: String?
    var duration: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        designation <- map["designation"]
        company     <- map["company"]
        duration    <- map["duration"]
    }
}

class CertificationReq: Mappable {
    var course: String?
    var institute: String?
    var duration: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        course     <- map["course"]
        institute  <- map["institute"]
        duration   <- map["duration"]
    }
}

class Project: Mappable {
    var title: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        title <- map["title"]
    }
}


import Foundation
import ObjectMapper

class ResumeUploadResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: [ResumeUploadData]?

    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}

class ResumeUploadData: Mappable {
    var status: Int?
    var message: String?
    var fileUrl: String?

    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        status   <- map["status"]
        message  <- map["message"]
        fileUrl  <- map["file_url"]
    }
}


import Foundation
import ObjectMapper

class ResumeTitleRequest: Mappable {
    var idMember: Int?
    var resumeTitle: [ResumeTitle]?

    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        idMember     <- map["idMember"]
        resumeTitle  <- map["resumeTitle"]
    }
}

class ResumeTitle: Mappable {
    var title: String?
    var url: String?
    var placementOfficer: Bool?

    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        title            <- map["title"]
        url              <- map["url"]
        placementOfficer <- map["placementOfficer"]
    }
}


class common_Response: Mappable {
    var status: Bool?
    var message: String?
    var data: [String]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}


import Foundation
import ObjectMapper

class ResumeTitleResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: ResumeTitleData?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}

class ResumeTitleData: Mappable {
    var resumeTitle: [ResumeTitle]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        resumeTitle <- map["resumeTitle"]
    }
}


import Foundation
import ObjectMapper

class ResumeUploadRequest: Mappable {
    var idMember: Int?
    var bucket: String?
    var bucketPath: String?
    var file: String? // This assumes the filename or file URL is passed as a string

    init(){}
    required init?(map: Map) {}

    func mapping(map: Map) {
        idMember   <- map["idMember"]
        bucket     <- map["bucket"]
        bucketPath <- map["bucketPath"]
        file       <- map["file"]
    }
}
