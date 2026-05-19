//
//  ParticularStafResponce.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 14/03/23.
//

import Foundation
import ObjectMapper

struct ParticularStaffModal : Codable {
  
    var collegeid : String?
    var staffid : String?
    var date : String?
}


struct particularStaffResponce : Codable{
    
    var Status : Int?
    var Message : String?
    var data : [particualrDataDetails]?
}


struct particualrDataDetails : Codable{
    
    var courseid : String?
    var coursename : String?
    var departmentid : String?
    var departmentname : String?
    var yearid : String?
    var yearname : String?
    var sectionid : String?
    var sectionname : String?
    var semesterid : String?
    var semestername : String?
    var subjectid : String?
    var subjectname : String?
    var subjecttype : String?
    var isSelected : Bool?
    var isedit   : String?
    var add_hours : [HoursdataDEtails]?
    var edit_hours : [editHoursdataDEtaild]?
    var attendance_type: String? //if attendance_type is "nth" then use period
}

struct HoursdataDEtails : Codable{
    var hour : Int?
    var period : Int?
}

struct editHoursdataDEtaild : Codable{
    
    var hour : Int?
    var title : String?
    var type : String?
    var period: Int?
}
