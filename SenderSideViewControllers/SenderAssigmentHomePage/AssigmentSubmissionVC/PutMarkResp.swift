//
//  PutMarkResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 29/02/24.
//

import Foundation

struct PutMarkResp: Codable {

    var assignmentid: String?
    var processby: String?
    var studentid: String?
    var assignmentdetailsid: String?
    var marks: String?
    var ImageChage: Bool?

}

struct PutMarkResponse: Codable {

    var Status: Int?
    var Message: String?

}
