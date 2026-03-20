//
//  SendImagePdfEntierClgResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 19/03/23.
//

import Foundation
import ObjectMapper

struct SendImagePdfModal: Codable {

    var collegeid: String?
    var Staffid: String?
    var callertype: String?
    var filetype: String?
    var fileduration: String?
    var isstudent: Bool?
    var isparent: Bool?
    var isstaff: Bool?
    var title: String?
    var Description: String?
    var FileNameArray: [FileNameImage]?

}

struct FileNameImage: Codable {

    var FileName: String?

}

struct SendImagePdfResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [sendImagePdfDataDetails]?

}

struct sendImagePdfDataDetails: Codable {

    var ivrheader: String?

}
