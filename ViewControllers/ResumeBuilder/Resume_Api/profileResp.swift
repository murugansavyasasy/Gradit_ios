//
//  profileResp.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 03/07/25.
//

import Foundation
import ObjectMapper


//MARK: User Profile Details
class Profile: Mappable {
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

    //required init?(map: Map) {}
    
    init(){}
    required init?(map: ObjectMapper.Map) {
        
        
        mapping(map: map)
    }

    func mapping(map: Map) {
        memberId                     <- map["memberId"]
        memberName                  <- map["memberName"]
        memberPhoneNumber           <- map["memberPhoneNumber"]
        memberstudentEmail          <- map["memberstudentEmail"]
        memberImagePath             <- map["memberImagePath"]
        memberPlacementStatus       <- map["memberPlacementStatus"]
        memberNotificationStatus    <- map["memberNotificationStatus"]
        memberRegno                 <- map["memberRegno"]
        memberDob                   <- map["memberDob"]
        memberGender                <- map["memberGender"]
        memberQualification         <- map["memberQualification"]
        memberPermanentAddress1     <- map["memberPermanentAddress1"]
        memberPermanentAddressCity  <- map["memberPermanentAddressCity"]
        memberPermanentAddressState <- map["memberPermanentAddressState"]
        memberPermanentAddressPincode <- map["memberPermanentAddressPincode"]
        memberPermanentAddressCountry <- map["memberPermanentAddressCountry"]
        memberAdmissionNo           <- map["memberAdmissionNo"]
        departmentName              <- map["departmentName"]
        semesterName                <- map["semesterName"]
        noOfYear                    <- map["noOfYear"]
        courseName                    <- map["courseName"]
    }
}

class Profile_Response: Mappable {
    var status: Bool?
    var message: String?
    var data: [Profile]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}


class Edit_Profile_Req : Mappable{
    
    var idMember : Int?
    var memberName : String?
    var primaryMobileNo : String?
    var studentEmail : String?
    var imagePath : String?
    var placementStatus : String?
    var notificationPlacement : Bool?
    var dob : String?
    var residentialAddressLine1 : String?
    
    init(){}
    
    required init?(map: ObjectMapper.Map) {
        mapping(map: map)
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        idMember <- map["idMember"]
        memberName <- map["memberName"]
        primaryMobileNo <- map["primaryMobileNo"]
        studentEmail <- map["studentEmail"]
        imagePath <- map["imagePath"]
        placementStatus <- map["placementStatus"]
        notificationPlacement <- map["notificationPlacement"]
        dob <- map["dob"]
        residentialAddressLine1 <- map["residentialAddressLine1"]
    }
}

class Edit_Profile_Response: Mappable {
    var status: Bool?
    var message: String?
    var data: [String]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}
