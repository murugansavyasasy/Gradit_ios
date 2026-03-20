//
//  EntierVideoResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 12/04/23.
//

import Foundation

struct EntierVideoUpload: Codable {

    var collegeid: String?
    var staffid: String?
    var callertype: String?
    var title: String?
    var description: String?
    var iframe: String?
    var url: String?
    var isstudent: Bool?
    var isparent: Bool?
    var isstaff: Bool?
    var FileName: String?

}

struct EntierVideoUploadResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [EntierVideoUploadDataDetails]?

}

struct EntierVideoUploadDataDetails: Codable {

    var ivrheader: String?

}
