//
//  ProfileResponse.swift
//  Vs_GradIt
//
//  Created by APPLE on 28/09/22.
//

import Foundation

struct ProfileResponse: Codable {

    var Status: Int?
    var Message: String?
    var data: [ProfileData]?

}

struct ProfileData: Codable {

    var key: String?
    var value: String?
    var type: String?

}
