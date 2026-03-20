

import Foundation

struct SenderUpcommingExamModal: Codable {

    var userid: String?
    var collegeid: String?
    var sectionid: String?
    var appid: String?
    var priority: String?
    var type: String?

}

struct SenderUpcommingExamResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [SenderUpcommingExamDataDetails]?

}

struct SenderUpcommingExamDataDetails: Codable {

    var headerid: String?
    var createdby: String?
    var examname: String?
    var startdate: String?
    var enddate: String?
    var createdon: String?
    var createdbyname: String?

}
