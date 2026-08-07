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
    var data : [VersionCheckData]?
}

struct VersionCheckData : Codable{
    var isversionupdateavailable : Int?
    var isforceupdaterequired    : Int?
    var resultvalue : String?
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
            print("❌ Decoding failed for \(T.self):", error)
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
    
    var menus: [menuApiDataDetails]{
        decodeArray(menuApiDataDetails.self)
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
    let detailsid: Int?
    let description: String?
    let voicefilepath: String?
    let duration: Int?
    let membername: String?
    let createdon: String?
}

struct AssignmentsDashType: Codable {
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
}

struct CircularDashType: Codable {
    let idfiledetails: Int?
    let title: String?
    let description: String?
    let filepaths: [String]?
    let createddate: String?
    let createdtime: String?
}

struct AttendanceDashType: Codable {
    let message: String?
    let subjectname: String?
    let attendancetype: String?
    let attendancedate: String?
}

struct RecentNotificationsDashType: Codable {
    let id: Int?
    let typ: String?
    let sentbyname: String?
    let createdondate: String?
    let createdontime: String?
    let content: String?
    let description: String?
    let duration: String?
}

struct UpcomingEventsDashType: Codable {
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

//MARK: Reciver events
struct eventsResponce : Codable{
    
    var  Status        : Int?
    var  Message       : String?
    var  data          :[Eventsdatadetails]?
}

struct Eventsdatadetails : Codable{
    
    var  eventid          : String?
    var  event_date       : String?
    var  event_time       : String?
    var  topic            : String?
    var  body             : String?
    var  venue            : String?
    var  createdbyname    : String?
    var  createdby        : String?
    var  filepath         : String?
    var  eventdetailsid   : String?
    var  isappread        : String?
    var  newfilepath      : [String]?
}

//MARK: Read status Api
struct ReadStausApiResponce : Codable{
    var  Status : Int?
    var Message : String?
}

//MARK: Receiver exam
struct examResponce : Codable{

    var  Status : Int?
    var  Message : String?
    var  data    :[examDataDetails]?
}

struct examDataDetails : Codable{
   
    var headerid            : String?
    var createdby           : String?
    var examname            : String?
    var subjectname         : String?
    var examvenue           : String?
    var session             : String?
    var syllabus            : String?
    var date                : String?
    var createdbyname       : String?
}

struct examViewResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [examViewResiverDataDetails]?
}

struct examViewResiverDataDetails : Codable{
    
    var subjectname : String?
    var marks : String?
}

//MARK: course details
struct courseResponce : Codable{
    
    var Status                   : Int?
    var Message                  : String?
    var data                     : [courseDataDetails]?
}

struct courseDataDetails : Codable{
    
    var  subject_id                    : String?
    var  subject_name                  : String?
    var  subject_code                  : String?
    var  subject_type                  : String?
    var  subject_credits               : String?
    var  subject_category              : String?
    var  subject_requirement           : String?
}

//MARK: category for credit points
struct categoryResponce : Codable{
    
    var Status    : Int?
    var Message   : String?
    var data      : [categoryDataDetails]?
}

struct categoryDataDetails : Codable{
    
    var category_id  : Int?
    var category_name : String?
}

//MARK: Credit points per category
struct creditResponce : Codable{
    
    var   Status  : Int?
    var   Message : String?
    var   data  : [creditDataDetails]?
}

struct creditDataDetails : Codable{
    
    var category_id : Int?
    var category_name : String?
    var semester_name : String?
    var total_credits : String?
    var obtained      : String?
    var to_be_obtained : String?
}

//MARK: Sem credit

struct semCreditDropDownResponce : Codable{
    
    var   Status     :     Int?
    var   Message    : String?
    var   data       : [semCreditDropDownDataDeails]?
}

struct semCreditDropDownDataDeails : Codable{
    
    var  semester_id : Int?
    var  semseter_name : String?
    var  semester_no : String?
    var isSelected : Bool?
}

struct semCreditDetailsResponce : Codable{
    
    var  Status  : Int?
    var  Message : String?
    var  data    :  [semcreditDataDetails]?
}


struct semcreditDataDetails : Codable{
    
    var category_id     : Int?
    var category_name   : String?
    var list            : [CategoryList]?
    var semester_name   : String?
    var total_credits   : String?
    var obtained        : String?
    var to_be_obtained  : String?
}


struct CategoryList : Codable{
    
    var category_id     : Int?
    var category_name   : String?
    var semester_name   : String?
    var total_credits   : String?
    var obtained        : String?
    var to_be_obtained  : String?
}

//MARK: Exam details
struct examDetailsResponce : Codable{
    
    var   Status     : Int?
    var   Message    : String?
    var   data       : [examesDataDetails]?
}

struct examesDataDetails : Codable{
    
    var    sem_number          :  String?
    var    subject_code        :  String?
    var    subject_name        :  String?
    var    amount              :  String?
}

//MARK: Hallticket
struct HallticketResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [HallticketDataDetails]?
}


struct HallticketDataDetails : Codable{
    
    var course_code : String
    var course_name : String
    var department : String
    var dob : String
    var register_number : String
    var student_name : String
    var current_sem : String
    var subject_sem_number : String
    var subject_code: String
    var subject_name : String
    var exam_date : String
    var exam_time : String
    var arrear_regular : String
    var course_wise_attendance : String
    var overall_semester_attendance : String
    var condonation_paid : String
    var student_image : String
    var college_logo  : String
}

//MARK: Voice history
struct HistorySmsVoiceResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data    : [HistorySmsVoiceDataDetail]?
}

struct HistorySmsVoiceDataDetail : Codable{
    
    var headerid : String?
    var timing   : String?
    var msgcontent : String?
    var description : String?
    var duration : String?
    var voicefile : String?
}

// MARK: - Student Assignment
struct AssignmentResponse: Codable {
    let Status: Int
    let Message: String
    let data: [AssignmentDetails]
}

struct AssignmentDetails: Codable {
    let assignmentdetailsid: String
    let obtainedmark: String?
    let filearray: [FileItem]
}

struct FileItem: Codable {
    let fileurl: String
    let filetype: String
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
