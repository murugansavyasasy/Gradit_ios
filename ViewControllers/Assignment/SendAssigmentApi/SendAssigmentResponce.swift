//
//  SendAssigmentResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 30/03/23.
//

import Foundation
import ObjectMapper

struct sendAssigmentModal: Codable {

    var assignmentid: String?
    var processby: String?
    var colgid: String?
    var description: String?
    var filetype: String?
    var FileNameArray: [filenamesss]?

}

struct filenamesss: Codable {

    var FileName: String?

}

struct sndAssigmentResponce: Codable {

    var Status: Int?
    var Message: String?

}
