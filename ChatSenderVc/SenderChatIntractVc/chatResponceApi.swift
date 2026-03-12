//
//  chatResponceApi.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 17/04/23.
//

import Foundation
import ObjectMapper


struct IntractApiModal : Codable{
    var staff_id : String?
    var college_id : String?
}

struct IntractChatResponces: Codable {
    var Status: Int?
    var Message: String?
    var data: [intractChatData]?
}

struct intractChatData: Codable {

    var courseid: String?
    var coursename: String?
    var yearid: String?
    var yearname: String?
    var departmentid: String?
    var departmentname: String?
    var semesterid: String?
    var semestername: String?
    var sectionid: String?
    var sectionname: String?
    var subjectid: String?
    var subjectname: String?
    var isclassteacher: String?

}

