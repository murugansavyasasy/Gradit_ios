//
//  verifyOTPResponce.swift
//  Vs_GradItCollege
//
//  Created by admin on 25/08/23.
//

import Foundation

struct recentOTPModal: Codable {

    var mobilenumber: String?
    var otp: String?

}

struct recentOTPResponce: Codable {

    var Status: Int?
    var Message: String?

}
