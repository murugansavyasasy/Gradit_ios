//
//  Model.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 05/03/26.
//

import Foundation

//MARK: Versioncheck
struct VersionCheckResponse : Codable{
    var Status: Int?
    var Message: String?
    var versionData : [VersionCheckData]?
}

struct VersionCheckData : Codable{
    var isversionupdateavailable : Int?
    var isforceupdaterequired    : Int?
    var resultvalue : Int?
    var resultmessage : String?
    var imagecount : String?
    var pdfcount : String?
    var eventphotoscount : String?
    var attendancedaycount : String?
    var privarypolicy : String?
    var faq : String?
    var help : String?
    var termsandcondition : String?
    var playstorelink : String?
    var versionalerttitle : String?
    var versionalertcontent : String?
    var playstoremarketid : String?
    var videojson      : String?
    var videosizelimit : String?
    var videosizealert : String?
    var feepaymentlink : String?
}

//MARK: Country List
struct CountryListResponse : Codable {
    var Status : Int?
    var Message : String?
    var data : [CountryData]?
}

struct CountryData : Codable{
    var countryid              : Int?
    var country                : String?
    var mobilenumberlen        : String?
    var baseurls               : String?
    var codecountry            : String?
    var idapplication          : Int?
    var isSelected             : Bool?
}

//MARK: Validate Mobile number
struct loginNewResponse : Codable{
    var Status : Int?
    var Message : String?
    var data : [loginNewDataDetail]?
}

struct loginNewDataDetail : Codable{
    var is_redirect_otp_screen : Int?
    var resultvalue : Int?
    var resultmessage : String?
    var otp : String?
    var ivrnumbers : [String]?
}

//MARK: Device token
struct DeviceTokenResponse: Codable {
    var Status : Int?
    var Message: String?
}

//MARK: Dashboard
struct DashBoardResponse : Codable  {
    var Status                      : Int?
    var Message                     : String?
    var data                    : [DashBoardData]?
}
      
struct DashBoardData: Codable {
    let type: String
    let order: Int
    let data: [[String: AnyCodable]]
}

extension DashBoardData {
    
    private func decodeArray<T: Decodable>(_ type: T.Type) -> [T] {
        
        do {
            let jsonData = try JSONEncoder().encode(data)
            let decoded = try JSONDecoder().decode([T].self, from: jsonData)
            return decoded
        } catch {
            return []
        }
    }
    
}

extension DashBoardData {
    
    var emerSubData: [EmergencyDashTypes] {
        decodeArray(EmergencyDashTypes.self)
    }
    
    var attendanceSubData: [AttendanceDashType] {
        decodeArray(AttendanceDashType.self)
    }
    
    var noticeSubData: [NoticeBoardDashType] {
        decodeArray(NoticeBoardDashType.self)
    }
    
    var recentNotificationSubData: [RecentNotificationsDashType] {
        decodeArray(RecentNotificationsDashType.self)
    }
    
    var circular: [CircularDashType] {
        decodeArray(CircularDashType.self)
    }
    
    var Events: [UpcomingEventsDashType] {
        decodeArray(UpcomingEventsDashType.self)
    }
    
    var assigment: [AssignmentsDashType] {
        decodeArray(AssignmentsDashType.self)
    }
    
    var Chat: [chatData] {
        decodeArray(chatData.self)
    }
    
    var leaveRequest: [LeaveRequestType] {
        decodeArray(LeaveRequestType.self)
    }
    
    var dashSubData: [AdData] {
        decodeArray(AdData.self)
    }
}

struct AnyCodable: Codable {
    
    let value: Any
    
    init(_ value: Any) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        if let int = try? container.decode(Int.self) {
            value = int
        } else if let double = try? container.decode(Double.self) {
            value = double
        } else if let string = try? container.decode(String.self) {
            value = string
        } else if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let array = try? container.decode([AnyCodable].self) {
            value = array
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            value = dictionary
        } else {
            value = ""
        }
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.singleValueContainer()
        
        switch value {
        case let int as Int:
            try container.encode(int)
        case let double as Double:
            try container.encode(double)
        case let string as String:
            try container.encode(string)
        case let bool as Bool:
            try container.encode(bool)
        default:
            try container.encodeNil()
        }
    }
}

struct LeaveRequestType: Codable {
    let appliedon: String
    let message: String?
    let fromdate: String?
    let coursename: String?
    let membername: String?
    let leavestatus: String?
    let reason: String?
    let noofdays: String?
    let todate: String?
    let departmentname: String?
    let sectionname: String?
    let leaveapplicationid: Int?
}

struct chatData: Codable {
    let coursename: String?
    let departmentname: String?
    let yearname: String?
    let sectionname: String?
    let studentname: String?
    let question: String?
    let createdon: String
    let message: String?
}

struct AdData: Codable {
    let add_title: String?
    let add_content: String?
    let company: String?
    let background_image: String?
    let add_image: String?
    let add_url: String?
    let video_url: String?
}

struct EmergencyDashTypes: Codable {
    let message: String
    let detailsid: Int
    let description: String
    let voicefilepath: String
    let duration: Int
    let membername: String
    let createdon: String
}

struct AssignmentsDashType: Codable {
    let message: String?
    let idassignmentdetails: Int?
    let assignmenttopic: String?
    let assignmentdescription: String?
    let submissiondate: String?
    let filepaths: [String]?
}

struct NoticeBoardDashType: Codable {
    let idnoticeboarddetails: Int?
    let topicheading: String?
    let topicbody: String?
    let createddate: String?
    let createdtime: String?
    let message: String?
}

struct CircularDashType: Codable {
    let idfiledetails: Int
    let title: String
    let description: String
    let filepaths: [String]
    let createddate: String
    let createdtime: String
    let message: String
}

struct AttendanceDashType: Codable {
    let message: String?
    let subjectname: String?
    let attendancetype: String?
    let attendancedate: String?
}

struct RecentNotificationsDashType: Codable {
    let message: String?
    let id: Int?
    let typ: String?
    let sentbyname: String
    let createdondate: String?
    let createdontime: String?
    let content: String?
    let description: String?
    let duration: String
}

struct UpcomingEventsDashType: Codable {
    let message: String?
    let ideventdetails: Int?
    let eventtopic: String?
    let eventdate: String?
    let eventtime: String?
}

//MARK: User Menu With Read Write Access
struct menuApiIdResponce : Codable{
    var Status     : Int
    var Message    : String
    var data       : [menuApiDataDetails]
}

struct menuApiDataDetails : Codable{
    
    var is_read_enabled :  Int
    var is_write_enabled : Int
    var menu_id   : Int
    var menu_name : String
    var menu_slug : String
    var order_id : Int
    var parent_id : Int
}

//MARK: Student Attendance
struct attendanceAbsentResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [attendanceAbesentDataDetails]?
}

struct attendanceAbesentDataDetails : Codable{
    
    var subjectname : String?
    var staff_name : String?
    var attended_hour : String?
    var absent_hour    : String?
    var subject_id   : Int?
    var staff_id   : Int?
    var total_hour : Int?
    var percentage : String?
}

//MARK: Student Leave Request
struct leaveResponce : Codable{
    var Status : Int?
    var Message : String?
    var data : [leaveDataDetails]?
}

struct leaveDataDetails : Codable{
    
    var createdon : String?
    var applicationid : String?
    var leaveapplicationtype : String?
    var leavefromdate : String?
    var leavetodate : String?
    var numofdays : String?
    var leavereason : String?
    var leavestatus : String?
    var leavestatusid : String?
}

//MARK: Get leave type
struct GetLeaveTypeResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [GetLeaveDataDetails]?
}

struct GetLeaveDataDetails : Codable{

    var leavetypeid : String?
    var leavetypename : String?
}

//MARK: Manage leave
struct manageLeaveResponce : Codable{
    var Status : Int?
    var Message : String?
}


//MARK: Sender Leave response
struct getLeaveTypeForSenderResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [getLeaveApplicationDataDetails]?
}

struct getLeaveApplicationDataDetails : Codable{
    
    var studentid : String?
    var studentname : String?
    var coursename : String?
    var departmentname : String?
    var yearname : String?
    var sectionname : String?
    var semestername : String?
    var applicationid : String?
    var leaveapplicationtype : String?
    var leavefromdate : String?
    var leavetodate : String?
    var leavereason : String?
    var leavestatus : String?
    var leavestatusid : String?
    var numofdays : String?
    var createdon : String?
}


// MARK: - Placement Event Response
struct MemberEventsResponse: Codable {
    var status: Bool?
    var message: String?
    var data: [MemberData]?
}

struct MemberData: Codable {
    var memberId: Int?
    var memberName: String?
    var events: [Event]?
    var shortlistCount: Int?
    var shortlistedEventIds: [Int]?
}

struct Event: Codable {
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
}

struct CompanyDetail: Codable {
    var id: Int?
    var logo: String?
    var companyName: String?
}


//MARK: Placement Training model
struct TrainingResponse: Codable {
    var status: Bool?
    var message: String?
    var data: [Training]?
}

struct Training: Codable {
    var careerId: Int?
    var trainingTitle: String?
    var trainingAbout: String?
    var trainingType: [String]?
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
    var repeatUntill: String?
    var createdOn: String?
    var departmentName: [String]?
    var semesterNo: [String]?
}

struct LoginResponse: Codable {
    var Status                          : Int?
    var Message                         : String?
    var data                            : [datalogin]?
}

struct datalogin : Codable{
    
    var colgid                                : Int?
    var memberid                              : Int?
    var priority                              : String?
    var membername                            : String?
    var colgname                              : String?
    var colgcity                              : String?
    var colglogo                              : String?
    var divid                                 : String?
    var divname                               : String?
    var courseid                              : String?
    var coursename                            : String?
    var deptid                                : String?
    var deptname                              : String?
    var yearid                                : String?
    var yearname                              : String?
    var sectionid                             : String?
    var sectionname                           : String?
    var semesterid                            : String?
    var semestername                          : String?
    var loginas                               : String?
    var is_parent_target_enabled              : String?
    var is_allow_to_make_call                 : Int?
}
