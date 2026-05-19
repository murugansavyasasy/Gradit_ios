

import Foundation

struct SenderPastExamModal: Codable {

    var userid: String?
    var collegeid: String?
    var sectionid: String?
    var appid: String?
    var priority: String?
    var type: String?

}

struct SenderPAstExamResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [SenderPastExamDataDetails]?
}

struct SenderPastExamDataDetails: Codable {

    var headerid: String?
    var createdby: String?
    var examname: String?
    var startdate: String?
    var enddate: String?
    var createdon: String?
    var createdbyname: String?

}
