//
//  ConfirmPasswordResp.swift
//  Vs_GradItCollege
//
//  Created by admin on 26/08/23.
//

import Foundation
import ObjectMapper


struct confirmPasswordModal : Codable{
    var mobilenumber : String!
    var newpassword  : String!
}

struct ConfirmPassResp : Codable{
    var Status : Int?
    var Message : String?
}
