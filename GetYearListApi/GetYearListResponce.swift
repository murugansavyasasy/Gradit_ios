//
//  GetYearListResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 25/03/23.
//

import Foundation

struct getYearListModal: Codable {

    var idcollege: String?
    var idcourse: String?
    var iddept: String?
    var clgprocessby: String?

}

struct getYearListResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [getYearListDataDetails]?

}

struct getYearListDataDetails: Codable {

    var yearid: Int?
    var yearname: String?

}
