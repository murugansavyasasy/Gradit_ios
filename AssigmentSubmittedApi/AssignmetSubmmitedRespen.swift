//
//  AssignmetSubmmitedRespen.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 06/04/23.
//

import Foundation

struct AssigmentSummitedModal: Codable {

    var assignmentid: String?
    var processby: String?
    var filetype: String?

}

struct AssigmentSubmitResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [AssignmentSubDataDetail]?

}

struct AssignmentSubDataDetail: Codable {

    var content: String?
    var description: String?
    var submittedtime: String?
    var file_name: String?

}
