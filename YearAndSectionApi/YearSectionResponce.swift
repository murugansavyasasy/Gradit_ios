//
//  YearSectionResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import Foundation
import ObjectMapper

struct YearAndSectionListforAppModal: Codable {

    var idcollege: String?
    var idcourse: String?
    var clgprocessby: String?

}

struct YearAndSectionListforAppResponse: Codable {

    var Status: Int?
    var Message: String?
    var data: [YearAndSectionListData]?

}

struct YearAndSectionListData: Codable {

    var yearid: Int?
    var yearname: String?
    var sectiondetails: [sectionDetailsData]?

}

struct sectionDetailsData: Codable {

    var sectionid: Int?
    var sectionname: String?
    var isSelected: Bool?

}
