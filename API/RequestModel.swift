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
