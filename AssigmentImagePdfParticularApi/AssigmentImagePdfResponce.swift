//
//  AssigmentImagePdfResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 29/03/23.
//

import Foundation
import ObjectMapper

struct assigmentImagePdfModal: Codable {

    var collegeid: String?
    var deptid: String?
    var courseid: String?
    var yearid: String?
    var staffid: String?
    var callertype: String?
    var sectionid: String?
    var subjectid: String?
    var assignmenttopic: String?
    var assignmentdescription: String?
    var submissiondate: String?
    var processtype: String?
    var assignmentid: String?
    var assignmenttype: String?
    var receivertype: String?
    var receiverid: String?
    var FileNameArray: [FileNameArray]?

}

struct FileNameArray: Codable {

    var FileName: String?

}

struct assigmentImagePdfResponce: Codable {

    var Status: Int?
    var Message: String?

}
