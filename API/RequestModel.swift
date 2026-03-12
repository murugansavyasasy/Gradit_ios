//
//  RequestModel.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 07/03/26.
//

//MARK: Validate Mobile number
struct loginNewModal : Codable{
    var mobile_number : String?
}

//MARK: Login
struct LoginModal: Codable{
    var mobilenumber : String?
    var Password : String?
}

//MARK: Device Token
struct DeviceTokenModal : Codable  {
    
    var mobileno : String?
    var devicetoken : String?
    var devicetype : String?
    
}

//MARK: Dashboard
struct DashBoardModal : Codable  {
    var collegeid                   : String?
    var userid                      : String?
    var priority                    : String?
}

// Read,Write Status
struct menuApiIdModal: Codable{
    
    var college_id : String?
    var user_id    :  String?
    var priority   : String?
}

//MARK: Student Attendance
struct attendanceAbesentModal : Codable{
    
    var userid : Int?
    var priority : String?
    var appid : Int?
}

//MARK: Student leaveRequest
struct leaveRequestModal : Codable{
    var collegeid : String?
    var staffid : String?
}

//MARK: Get leave type
struct GetLeaveTypeModal : Codable{

    var appid : String?
    var userid : String?
}

//MARK: Manage leave
struct manageLeaveModal : Codable{
  
    var colgid : String?
    var memberid : String?
    var applicationid : String?
    var leavetypeid : String?
    var leavefromdate : String?
    var leavetodate : String?
    var numofdays : String?
    var clgsectionid : String?
    var leavereason : String?
    var processtype : String?
}

//MARK: Reciver events
struct eventsModal : Codable{
    var userid   :  String?
    var appid    : String?
    var priority : String?
    var type     : String?
}

//MARK: read status
struct AppReadStatusModal : Codable{
    
    var userid : String?
    var msgtype : String?
    var detailsid : String?
    var priority : String?
}

//MARK: receiver exam
struct examModal : Codable{
    
    var  userid         : String?
    var  collegeid      : String?
    var  sectionid      : String?
    var  appid          : String?
    var  priority       : String?
    var  type           : String?
}

struct examViewModal : Codable{
    var studentid : String?
    var examheaderid : String?
}

//MARK: Get course details
struct courseModal : Codable{
    
    var user_id    : String?
    var college_id : String?
    var dept_id    : String?
    var sem_id     : String?
    var section_id : String?
}

//MARK: Get category
struct categoryModal : Codable{
    
    var  colgid          : String?
    var  i_student_id    :  String?
}

//MARK: Credit
struct creditModal : Codable{
    
    var colgid      : String?
    var i_course_id : String?
    var i_category_id : String?
    var i_student_id : String?
}

//MARK: Sem Credit

struct semCreditDropDownModal : Codable{
    
    var colgid           : String?
    var i_course_id       : String?
}

struct semcreditDetailsModal : Codable{
    
    var  colgid         :    String?
    var  i_course_id    :   String?
    var i_semester_id   :  Int?
    var i_student_id    :  String?
}

//MARK: Exam Details
struct examDetailsModal : Codable{
    
    var  i_course_id        : String?
    var  colgid             : String?
    var  i_semester_id      : String?
    var  i_student_id       : String?
}

//MARK: Halltickets
struct HallticketModal : Codable{
    
    var i_course_id : Int?
    var colgid : Int?
    var i_semester_id : Int?
    var i_student_id : Int?
}

//MARK: Voice and text history
struct HistorySmsVoiceModal : Codable{
   
    var userid : String?
    var priority : String?
    var appid  : String?
}
