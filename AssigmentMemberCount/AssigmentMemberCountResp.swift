//
//  AssigmentMemberCountResp.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 05/04/23.
//

import Foundation

struct assigmentMemberCountModal: Codable {

    var assignmentid: String?
    var processby: String?
    var submissiontype: String?

}

struct assigmentMemberCountResponce: Codable {

    var Status: Int?
    var message: String?
    var data: [AssigmentmebCountData]?

}

struct AssigmentmebCountData: Codable {

    var studentid: String?
    var assignmentdetailsid: String?
    var obtainedmark: String?
    var filearray: [FilepathDataDetails]?
    var studentname: String?
    var year: String?
    var course: String?
    var ImageShow: Bool?
    var register_number: String?

}

struct FilepathDataDetails: Codable {

    var fileurl: String?
    var filetype: String?

}
