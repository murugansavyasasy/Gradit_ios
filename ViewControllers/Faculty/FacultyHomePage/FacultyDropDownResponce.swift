

import Foundation
import ObjectMapper

struct dropDownModal: Codable {

    var yearid: String?

}

struct dropDownResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [dropDownDataDetails]?

}

struct dropDownDataDetails: Codable {

    var clgsemesterid: String?
    var semestername: String?
    var sectiondetails: [dropDownSectionDetails]?

}

struct dropDownSectionDetails: Codable {

    var sectionid: String?
    var sectionname: String?

}
