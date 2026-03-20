

import Foundation

struct forgetModal: Codable {

    var mobilenumber: String?

}

struct forgetResponce: Codable {

    var Status: Int?
    var Message: String?
    var data: [dataForgetDetails]?

}

struct dataForgetDetails: Codable {

    var ivrnumbers: [String]?

}





