//
//  ImagePdfPartiResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 30/03/23.
//

import Foundation

struct ImagePdfPartResponce: Codable {

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
    var receivertype: String?
    var subjectid: String?
    var receiverid: String?
    var FileNameArray: [FileNameImages]?

}

struct FileNameImages: Codable {

    var FileName: String?

}

struct SendImagePdfPartiResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [sendImagePdfPartiDataDetails]?

}

struct sendImagePdfPartiDataDetails: Codable {

    var ivrheader: String?

}
