

import Foundation
import ObjectMapper

struct changePasswordModal: Codable {

    var mobilenumber: String?
    var oldpassword: String?
    var newpassword: String?

}

struct changePasswordResponse: Codable {

    var Status: Int?
    var Message: String?

}
