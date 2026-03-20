

import Foundation
import ObjectMapper

struct chageModal: Codable {

    var mobilenumber: String?
    var oldpassword: String?
    var newpassword: String?

}

struct chageResponce: Codable {

    var Status: Int?
    var Message: String?

}
