//
//  PlacementEventApiReq&Resp.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 24/08/25.
//

import Foundation
import KRProgressHUD

class DummyBase{
    static let base = "http://192.168.5.107:3002/api/"
}

//MARK: API Request
class Get_PlacementEvents_Request{
    
    static func call_request(param : [String: Any], completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()

        BaseRequest.getAny(url: get_url(), param: param).success {

            (res) in

            completion_handler (res as! String)
        }
    }

    private static func get_url() -> String{

       // return String(format: "%@placementEvents/getPlacementAll", Constant.Resume_baseUrl)
        return String(format: "%@students/student-placement-events", Constant.Resume_baseUrl)
    }
}

class Get_Historical_PlacementEvents_Request{
    
    static func call_request(param : [String: Any], completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()

        BaseRequest.getAny(url: get_url(), param: param).success {

            (res) in

            completion_handler (res as! String)
        }
    }

    private static func get_url() -> String{

       // return String(format: "%@placementEvents/getPlacementAll", Constant.Resume_baseUrl)
        return String(format: "%@students/student-placement-events-historical", Constant.Resume_baseUrl)
    }
}

class Get_PlacementTrainings_Request{
    
    static func call_request(param : [String: Any], completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()

        BaseRequest.getAny(url: get_url(), param: param).success {

            (res) in

            completion_handler (res as! String)
        }
    }

    private static func get_url() -> String{

       // return String(format: "%@placementEvents/getPlacementAll", Constant.Resume_baseUrl)
        return String(format: "%@students/student-career", Constant.Resume_baseUrl)
    }
}

class Get_Historical_PlacementTrainings_Request{
    
    static func call_request(param : [String: Any], completion_handler : @escaping(String)->()) {

        KRProgressHUD.show()

        BaseRequest.getAny(url: get_url(), param: param).success {

            (res) in

            completion_handler (res as! String)
        }
    }

    private static func get_url() -> String{

       // return String(format: "%@placementEvents/getPlacementAll", Constant.Resume_baseUrl)
        return String(format: "%@students/student-career-historical", Constant.Resume_baseUrl)
    }
}

//MARK: API Response Model

import Foundation
import ObjectMapper

// MARK: - Root Response
class MemberEventsResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: [MemberData]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}

// MARK: - Member Data
class MemberData: Mappable {
    var memberId: Int?
    var memberName: String?
    var events: [Event]?
    var shortlistCount: Int?
    var shortlistedEventIds: [Int]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        memberId            <- map["memberId"]
        memberName          <- map["memberName"]
        events              <- map["events"]
        shortlistCount      <- map["shortlistCount"]
        shortlistedEventIds <- map["shortlistedEventIds"]
    }
}

// MARK: - Event
class Event: Mappable {
    var eventId: Int?
    var eventTitle: String?
    var aboutEvent: String?
    var modeOfEvent: String?
    var eventDate: String?
    var eventTime: String?
    var venue: String?
    var companyDetails: [CompanyDetail]?
    var eligibleCourses: [String]?
    var eligibleCriteria: String?
    var selectionProcess: [String]?

    required init?(map: Map) {}

//    func mapping(map: Map) {
//        eventId          <- map["eventId"]
//        eventTitle       <- map["eventTitle"]
//        aboutEvent       <- map["aboutEvent"]
//        modeOfEvent      <- map["modeOfEvent"]
//        eventDate        <- map["eventDate"]
//        eventTime        <- map["eventTime"]
//        venue            <- map["venue"]
//        companyDetails   <- map["companyDetails"]
//        eligibleCriteria <- map["eligibleCriteria"]
//        selectionProcess <- map["selectionProcess"]
//
//        // Parse stringified array for eligibleCourses
//        var rawCourses: String?
//        rawCourses <- map["eligibleCourses"]
//        if let raw = rawCourses,
//           let data = raw.data(using: .utf8),
//           let courses = try? JSONSerialization.jsonObject(with: data, options: []) as? [String] {
//            eligibleCourses = courses
//        }
//    }
    
    func mapping(map: Map) {
        eventId          <- map["eventId"]
        eventTitle       <- map["eventTitle"]
        aboutEvent       <- map["aboutEvent"]
        modeOfEvent      <- map["modeOfEvent"]
        eventDate        <- map["eventDate"]
        eventTime        <- map["eventTime"]
        venue            <- map["venue"]
        companyDetails   <- map["companyDetails"]
        eligibleCourses  <- map["eligibleCourses"]  // Direct mapping
        eligibleCriteria <- map["eligibleCriteria"]
        selectionProcess <- map["selectionProcess"]
    }

}

// MARK: - Company Detail
class CompanyDetail: Mappable {
    var id: Int?
    var logo: String?
    var companyName: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        id          <- map["id"]
        logo        <- map["logo"]
        companyName <- map["companyName"]
    }
}


//MARK: Traing Api model class

import Foundation
import ObjectMapper

// MARK: - Root Response
class TrainingResponse: Mappable {
    var status: Bool?
    var message: String?
    var data: [Training]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        status  <- map["status"]
        message <- map["message"]
        data    <- map["data"]
    }
}

// MARK: - Training Model
class Training: Mappable {
    var careerId: Int?
    var trainingTitle: String?
    var trainingAbout: String?
    var trainingType: String?
    var trainingDate: String?
    var modeTraining: String?
    var startTime: String?
    var endTime: String?
    var venue: String?
    var trainerName: String?
    var applicableBatches: [String]?
    var recursiveTraining: Bool?
    var repeatTraining: String?
    var selectDay: String?
    var repeatUntil: String?
    var createdOn: String?
    var departmentName: [String]?
    var semesterNo: [String]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        careerId          <- map["careerId"]
        trainingTitle     <- map["trainingTitle"]
        trainingAbout     <- map["trainingAbout"]
        trainingType      <- map["trainingType"]
        trainingDate      <- map["trainingDate"]
        modeTraining      <- map["modeTraining"]
        startTime         <- map["startTime"]
        endTime           <- map["endTime"]
        venue             <- map["venue"]
        trainerName       <- map["trainerName"]
        applicableBatches <- map["applicableBatches"]
        recursiveTraining <- map["recursiveTraining"]
        repeatTraining    <- map["repeatTraining"]
        selectDay         <- map["selectDay"]
        repeatUntil       <- map["repeatUntill"]
        createdOn         <- map["createdOn"]
        departmentName    <- map["departmentName"]
        semesterNo        <- map["semesterNo"]
    }
}
