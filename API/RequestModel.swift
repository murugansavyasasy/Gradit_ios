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
