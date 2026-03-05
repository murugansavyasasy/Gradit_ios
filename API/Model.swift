//
//  Model.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 05/03/26.
//

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
}
