//
//  ResumeGenerate_Resp.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 16/07/25.
//

import Foundation

import Foundation
import ObjectMapper

struct TemplateResponse: Codable {
    
    var status: Bool?
    var message: String?
    var data: [TemplateData]?
    
}

struct TemplateData: Codable {
    
    var template: [ResumeTemplate]?
    var themecolor: [String]?

}

struct ResumeTemplate: Codable {
    
    var resume_template_name: String?
    var resume_template_image: String?
}


import Foundation
import ObjectMapper

struct ResumeRequest: Codable {
    
    var context: ResumeContext?
    var templateNumber: Int?
    var themeColor: String?
    var bucket: String?
    var bucketPath: String?
    var idMember: Int?
}

struct ResumeContext: Codable {
    
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

}

struct Education: Codable {
    
    var `class`: String?
    var degree: String?
    var percentage: String?
    var institution: String?

}

struct Experience: Codable {
    
    var designation: String?
    var company: String?
    var duration: String?

}

struct CertificationReq: Codable {
    var course: String?
    var institute: String?
    var duration: String?

}

struct Project: Codable {
    var title: String?
}


import Foundation
import ObjectMapper

struct ResumeUploadResponse: Codable {
    var status: Bool?
    var message: String?
    var data: [ResumeUploadData]?

}

struct ResumeUploadData: Codable {
    var status: Int?
    var message: String?
    var file_url: String?
}


import Foundation

struct ResumeTitleRequest: Codable {
    var idMember: Int?
    var resumeTitle: [ResumeTitle]?

}

struct ResumeTitle: Codable {
    var title: String?
    var url: String?
    var placementOfficer: Bool?

}


struct common_Response: Codable {
    var status: Bool?
    var message: String?
    var data: [String]?

}

struct uploadResumeResponse: Codable {
    var status: Bool?
    var message: String?
}

struct ResumeTitleResponse: Codable {
    var status: Bool?
    var message: String?
    var data: ResumeTitleData?

}

struct ResumeTitleData: Codable {
    var resumeTitle: [ResumeTitle]?

}

struct ResumeUploadRequest: Codable {
    var idMember: Int?
    var bucket: String?
    var bucketPath: String?
    var file: String? 
}

struct ResumeDeleteReq: Codable {
    let resumeUrl: String?
}
