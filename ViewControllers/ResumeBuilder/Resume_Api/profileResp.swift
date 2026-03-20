//
//  profileResp.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 03/07/25.
//

import Foundation
import ObjectMapper


//MARK: User Profile Details
struct Profile: Codable {

    var memberId: Int?
    var memberName: String?
    var memberPhoneNumber: String?
    var memberstudentEmail: String?
    var memberImagePath: String?
    var memberPlacementStatus: String?
    var memberNotificationStatus: Bool?
    var memberRegno: String?
    var memberDob: String?
    var memberGender: String?
    var memberQualification: String?
    var memberPermanentAddress1: String?
    var memberPermanentAddressCity: String?
    var memberPermanentAddressState: String?
    var memberPermanentAddressPincode: String?
    var memberPermanentAddressCountry: String?
    var memberAdmissionNo: String?
    var departmentName: String?
    var semesterName: String?
    var noOfYear: Int?
    var courseName: String?

}

struct Profile_Response: Codable {

    var status: Bool?
    var message: String?
    var data: [Profile]?

}

struct Edit_Profile_Req: Codable {

    var idMember: Int?
    var memberName: String?
    var primaryMobileNo: String?
    var studentEmail: String?
    var imagePath: String?
    var placementStatus: String?
    var notificationPlacement: Bool?
    var dob: String?
    var residentialAddressLine1: String?

}

struct Edit_Profile_Response: Codable {

    var status: Bool?
    var message: String?

}
